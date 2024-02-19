//
//  Mock.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import UIKit

@MainActor
enum Mock {
    private static var lamboImageString: String? {
        UIImage(named: "Lambo")!.base64String
    }

    static let chatView = ChatView(viewModel: chatViewModel)

    static let chatViewModel = ChatViewModel(chatService: MockChatService(), chatMessages: chatMessages, prompt: "")

    static let chatMessage = Message(role: .user, text: MockConstants.nearbyLocations)

    static var chatMessageWithImage: Message {
        var message = chatMessage
        message.image = lamboImageString
        return message
    }

    static var chatMessages: [Message] {
        [
            Message(role: .assistant, text: MockConstants.glad),
            Message(role: .user, text: MockConstants.nearbyLocations),
            Message(role: .assistant, text: MockConstants.glad),
            Message(role: .user, text: MockConstants.nearbyLocations),
            Message(role: .assistant, text: MockConstants.glad),
            Message(role: .user, text: MockConstants.nearbyLocations),
            Message(role: .assistant, text: MockConstants.glad),
            Message(role: .user, text: MockConstants.nearbyLocations),
            Message(role: .assistant, text: MockConstants.no),
            Message(role: .user, text: MockConstants.nearbyLocations),
            Message(role: .assistant, text: MockConstants.glad),
            Message(role: .user, text: MockConstants.nearbyLocations),
            Message(role: .assistant, text: MockConstants.glad),
            Message(role: .user, text: MockConstants.nearbyLocations),
            Message(role: .assistant, text: MockConstants.glad),
            Message(role: .user, text: MockConstants.nearbyLocations),
            Message(role: .assistant, text: MockConstants.glad),
            Message(role: .user, text: MockConstants.nearbyLocations, image: lamboImageString),
        ]
    }
}
