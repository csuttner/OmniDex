//
//  MockChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation
import OpenAI

class MockChatService: ChatService {
    func fetchChatCompletion(text: String, image _: String?, history _: [OpenAI.ChatMessage]) async throws -> OpenAI.ChatCompletionResponse {
        try await Task.sleep(for: .seconds(1))

        let message = OpenAI.ChatMessage(role: .assistant, text: MockConstants.longResponse)

        return ChatCompletionResponse.mockResponse(message: message)
    }
    
    func fetchChatCompletionStream(text: String, image: String?, history: [OpenAI.ChatMessage]) async throws -> AsyncThrowingStream<OpenAI.ChatCompletionChunk, Error> {
        
        let chunk = OpenAI.ChatCompletionChunk(
            id: UUID().uuidString,
            choices: [ChatCompletionChoice(
                delta: OpenAI.ChatMessage(role: .assistant, text: MockConstants.glad)
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
