//
//  Mock.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI
import UIKit

@MainActor
enum Mock {
    private static var lamboImageString: String? {
        UIImage(named: "Lambo")!.base64String
    }

    static let chatView = ChatView(viewModel: chatViewModel)
    
    static let chatStreamView = ChatStreamView(viewModel: chatStreamViewModel)
    
    static let chatStreamViewModel = ChatStreamViewModel(chatService: MockChatService(), chatMessages: chatMessages, prompt: "")

    static let chatViewModel = ChatViewModel(chatService: MockChatService(), chatMessages: chatMessages, prompt: "")

    static let chatMessage = ChatMessage(role: .user, text: MockConstants.nearbyLocations)

    static var chatMessageWithImage: ChatMessage {
        var message = chatMessage
        message.image = lamboImageString
        return message
    }

    static var chatMessages: [ChatMessage] {
        [
            ChatMessage(role: .assistant, text: MockConstants.glad),
            ChatMessage(role: .user, text: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, text: MockConstants.glad),
            ChatMessage(role: .user, text: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, text: MockConstants.glad),
            ChatMessage(role: .user, text: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, text: MockConstants.glad),
            ChatMessage(role: .user, text: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, text: MockConstants.no),
            ChatMessage(role: .user, text: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, text: MockConstants.glad),
            ChatMessage(role: .user, text: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, text: MockConstants.glad),
            ChatMessage(role: .user, text: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, text: MockConstants.glad),
            ChatMessage(role: .user, text: MockConstants.nearbyLocations),
            ChatMessage(role: .assistant, text: MockConstants.glad),
            ChatMessage(role: .user, text: MockConstants.nearbyLocations, image: lamboImageString),
        ]
    }
}
