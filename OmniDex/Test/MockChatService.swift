//
//  MockChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation
import OpenAISwift

class MockChatService: ChatService {
    func fetchChatCompletion(text: String, image _: String?, history _: [OpenAISwift.Message]) async throws -> CompletionResponse {
        try await Task.sleep(for: .seconds(1))

        let message = OpenAISwift.Message(role: .assistant, text: MockConstants.longResponse)

        return CompletionResponse.mockResponse(message: message)
    }
    
    func streamChatCompletion(text: String, image: String?, history: [OpenAISwift.Message]) async throws -> AsyncThrowingStream<CompletionChunk, Error> {
        
        let chunk = CompletionChunk(
            id: UUID().uuidString,
            choices: [CompletionChoice(
                delta: OpenAISwift.Message(role: .assistant, text: MockConstants.glad)
            )]
        )
        
        return AsyncThrowingStream { continuation in
            Task {
                for index in 0..<10 {
                    continuation.yield(chunk)
                    
                    try await Task.sleep(for: .milliseconds(300))
                }

                continuation.finish()
            }
        }
    }
}
