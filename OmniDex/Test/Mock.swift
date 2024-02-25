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

    static let chatMessage = Message(text: MockConstants.nearbyLocations)

    static var chatMessageWithImage: Message {
        var message = chatMessage
        message.image = lamboImageString
        return message
    }

    static var chatMessages: [Message] {
        [
            Message(isUser: false, text: MockConstants.glad),
            Message(text: MockConstants.nearbyLocations),
            Message(isUser: false, text: MockConstants.glad),
            Message(text: MockConstants.nearbyLocations),
            Message(isUser: false, text: MockConstants.glad),
            Message(text: MockConstants.nearbyLocations),
            Message(isUser: false, text: MockConstants.glad),
            Message(text: MockConstants.nearbyLocations),
            Message(isUser: false, text: MockConstants.no),
            Message(text: MockConstants.nearbyLocations),
            Message(isUser: false, text: MockConstants.glad),
            Message(text: MockConstants.nearbyLocations),
            Message(isUser: false, text: MockConstants.glad),
            Message(text: MockConstants.nearbyLocations),
            Message(isUser: false, text: MockConstants.glad),
            Message(text: MockConstants.nearbyLocations),
            Message(isUser: false, text: MockConstants.glad),
            Message(text: MockConstants.nearbyLocations, image: lamboImageString),
        ]
    }
}
