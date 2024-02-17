//
//  ChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import OpenAI

protocol ChatService {
    func fetchChatCompletion(text: String, image: String?, history: [OpenAI.ChatMessage]) async throws -> ChatCompletionResponse
    func streamChatCompletion(text: String, image: String?, history: [OpenAI.ChatMessage]) async throws -> AsyncThrowingStream<OpenAI.ChatCompletionChunk, Error>
}

extension OpenAIChatService: ChatService {}
