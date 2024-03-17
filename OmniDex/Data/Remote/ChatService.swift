//
//  ChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation
import OpenAISwift

protocol ChatService {
    func fetchChatCompletion(text: String, image: String?, history: [Message]) async throws -> Message
    func streamChatCompletion(text: String, image: String?, history: [Message]) async throws -> AsyncThrowingStream<MessageChunk, Error>
}

extension OpenAISwift.ChatService: ChatService {
    func fetchChatCompletion(text: String, image: String?, history: [Message]) async throws -> Message {
        let payload = CompletionPayload(text: text, image: image, history: history)
        let completion = try await fetchChatCompletion(payload: payload)
        
        return Message(
            id: completion.id,
            date: completion.created,
            isUser: false,
            text: completion.choices.first?.message?.textContent ?? ""
        )
    }
    
    func streamChatCompletion(text: String, image: String?, history: [Message]) async throws -> AsyncThrowingStream<MessageChunk, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    let payload = CompletionPayload(text: text, image: image, history: history, stream: true)
                    let stream = await streamChatCompletion(payload: payload)

                    for try await chunk in stream  {
                        continuation.yield(chunk.localChunk)
                    }
                    
                    continuation.finish()
                    
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}

private extension CompletionPayload {
    init(text: String, image: String?, history: [Message], stream: Bool? = nil) {
        var history = history.map(\.remoteMessage)
        history.append(OpenAISwift.Message(role: .user, text: text, image: image))
        
        self.init(messages: history, model: .gpt4VisionPreview, maxTokens: 1000, stream: stream)
    }
}

private extension Message {
    var remoteMessage: OpenAISwift.Message {
        OpenAISwift.Message(
            role: isUser ? .user : .assistant,
            text: text,
            image: image
        )
    }
}

private extension CompletionChunk {
    var localChunk: MessageChunk {
        MessageChunk(
            id: id,
            date: created,
            text: choices.first?.delta?.textContent ?? ""
        )
    }
}
