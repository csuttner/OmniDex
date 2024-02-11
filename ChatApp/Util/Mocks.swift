//
//  Mocks.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

enum Mocks {
    static let chatViewModel = ChatViewModel(chatService: MockChatService(), chatMessages: chatMessages, prompt: "")
    
    static let chatMessageViewModel = ChatMessageViewModel(
        chatMessage: makeChatMessage(role: .user, content: Constants.Mock.nearbyLocations)
    )
    
    static let chatMessageViewModelLoading = ChatMessageViewModel(
        chatMessage: makeChatMessage(role: .user, content: "", isLoading: true)
    )
    
    private static var chatMessages: [ChatMessage] {
        [
            makeChatMessage(role: .assistant, content: Constants.Mock.glad),
            makeChatMessage(role: .user, content: Constants.Mock.nearbyLocations),
            makeChatMessage(role: .assistant, content: Constants.Mock.glad),
            makeChatMessage(role: .user, content: Constants.Mock.nearbyLocations),
            makeChatMessage(role: .assistant, content: Constants.Mock.glad),
            makeChatMessage(role: .user, content: Constants.Mock.nearbyLocations),
            makeChatMessage(role: .assistant, content: Constants.Mock.glad),
            makeChatMessage(role: .user, content: Constants.Mock.nearbyLocations),
            makeChatMessage(role: .assistant, content: Constants.Mock.no),
            makeChatMessage(role: .user, content: "", isLoading: true)
        ]
    }
    
    private static func makeChatMessage(role: Role = .user, content: String = "", isLoading: Bool = false) -> ChatMessage {
        ChatMessage(
            id: UUID().uuidString,
            date: Date(),
            sender: MessageSender(role: role),
            content: content,
            isLoading: isLoading
        )
    }
}

class MockChatService: ChatService {
    func fetchChatCompletion(prompt: String, history: [OpenAI.ChatMessage]) async throws -> OpenAI.ChatCompletionResponse {
        ChatCompletionResponse(
            id: "",
            choices: [],
            created: Date(),
            model: "",
            systemFingerprint: nil,
            object: "",
            usage: ChatUsage(promptTokens: 0, completionTokens: 0, totalTokens: 0)
        )
    }
}
