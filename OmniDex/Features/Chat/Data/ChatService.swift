//
//  ChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation
import OpenAISwift

protocol ChatService {
    func fetchChatCompletion(text: String, image: String?, history: [OpenAISwift.Message]) async throws -> CompletionResponse
    func streamChatCompletion(text: String, image: String?, history: [OpenAISwift.Message]) async throws -> AsyncThrowingStream<CompletionChunk, Error>
}

extension OpenAISwift.ChatService: ChatService {}
