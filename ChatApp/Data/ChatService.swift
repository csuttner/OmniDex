//
//  ChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import OpenAI

protocol ChatService {
    func fetchChatCompletion(prompt: String, history: [OpenAI.ChatMessage]) async throws -> ChatCompletionResponse
}

extension OpenAIChatService: ChatService {}
