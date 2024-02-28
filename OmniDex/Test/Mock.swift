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

    static let chatViewModel = Conversation(chatService: MockChatService(), messages: chatMessages, prompt: "")

    static let chatMessage = Message(text: MockConstants.nearbyLocations)

    static var chatMessageWithImage = Message(text: MockConstants.nearbyLocations, image: lamboImageString)

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
