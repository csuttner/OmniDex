//
//  MockChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

class MockChatService: ChatService {
    func fetchChatCompletion(text: String, image _: String?, history _: [Message]) async throws -> Message {
        try await Task.sleep(for: .seconds(1))

        return Message(text: PreviewConstants.nearbyLocations)
    }
    
    func streamChatCompletion(text: String, image _: String?, history _: [Message]) async throws -> AsyncThrowingStream<MessageChunk, Error> {
        let chunk = MessageChunk(
            id: UUID().uuidString,
            date: Date(),
            text: PreviewConstants.glad
        )
        
        return AsyncThrowingStream { continuation in
            Task {
                for _ in 0..<10 {
                    continuation.yield(chunk)
                    
                    try await Task.sleep(for: .milliseconds(300))
                }

                continuation.finish()
            }
        }
    }
}
