//
//  MockChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import OpenAI
import Foundation

class MockChatService: ChatService {
    func fetchChatCompletion(text: String, image: String?, history: [OpenAI.ChatMessage]) async throws -> OpenAI.ChatCompletionResponse {
        try await Task.sleep(for: .seconds(1))
        
        let message = OpenAI.ChatMessage(role: .assistant, text: MockConstants.longResponse)
        
        return ChatCompletionResponse.mockResponse(message: message)
    }
}
