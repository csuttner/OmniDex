//
//  Mocks.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

enum Mock {
    static let chatView = ChatView(viewModel: chatViewModel)

    static let chatViewModel = ChatViewModel(chatService: MockChatService(), chatMessages: chatMessages, prompt: "")
    
    static let chatMessageViewModel = ChatMessageViewModel(
        chatMessage: ChatMessage(role: .user, content: MockConstants.nearbyLocations)
    )
    
    static let chatMessageViewModelLoading = ChatMessageViewModel(
        chatMessage: ChatMessage(role: .user, isLoading: true)
    )
    
    static var chatMessages: [ChatMessage] {
        [
            ChatMessage(role: .assistant, content: MockConstants.glad),
            ChatMessage(role: .user, content: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, content: MockConstants.glad),
            ChatMessage(role: .user, content: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, content: MockConstants.glad),
            ChatMessage(role: .user, content: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, content: MockConstants.glad),
            ChatMessage(role: .user, content: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, content: MockConstants.no),
            ChatMessage(role: .user, content: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, content: MockConstants.glad),
            ChatMessage(role: .user, content: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, content: MockConstants.glad),
            ChatMessage(role: .user, content: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, content: MockConstants.glad),
            ChatMessage(role: .user, content: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, content: MockConstants.glad)
        ]
    }
}
