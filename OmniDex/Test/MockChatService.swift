//
//  MockChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

class MockChatService: ChatService {
    func fetchChatCompletion(text: String, image _: String?, history _: [ChatMessage]) async throws -> ChatCompletionResponse {
        try await Task.sleep(for: .seconds(1))

        let message = ChatMessage(role: .assistant, text: MockConstants.longResponse)

        return ChatCompletionResponse.mockResponse(message: message)
    }
    
    func streamChatCompletion(text: String, image: String?, history: [ChatMessage]) async throws -> AsyncThrowingStream<ChatCompletionChunk, Error> {
        
        let chunk = ChatCompletionChunk(
            id: UUID().uuidString,
            choices: [ChatCompletionChoice(
                delta: ChatMessage(role: .assistant, text: MockConstants.glad)
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
