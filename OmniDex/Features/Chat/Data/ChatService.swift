//
//  ChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

protocol ChatService {
    func fetchChatCompletion(text: String, image: String?, history: [ChatMessage]) async throws -> ChatCompletionResponse
    func streamChatCompletion(text: String, image: String?, history: [ChatMessage]) async throws -> AsyncThrowingStream<ChatCompletionChunk, Error>
}

extension OpenAIChatService: ChatService {}
