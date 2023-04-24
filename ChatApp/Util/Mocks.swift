//
//  Mocks.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

enum Mocks {
    static let chatViewModel = ChatViewModel(chatMessages: chatMessages, prompt: "")
    
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
            makeChatMessage(role: .assistant, content: Constants.Mock.no),
            makeChatMessage(role: .user, content: "", isLoading: true)
        ]
    }
    
    private static func makeChatMessage(role: AIRole = .user, content: String = "", isLoading: Bool = false) -> ChatMessage {
        ChatMessage(
            id: UUID().uuidString,
            date: Date(),
            sender: MessageSender(role: role),
            content: content,
            isLoading: isLoading
        )
    }
}
