//
//  ChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

protocol ChatService {
    func fetchChatCompletion(text: String, image: String?, history: [OpenAIChatMessage]) async throws -> ChatCompletionResponse
    func streamChatCompletion(text: String, image: String?, history: [OpenAIChatMessage]) async throws -> AsyncThrowingStream<ChatCompletionChunk, Error>
}

extension OpenAIChatService: ChatService {}
