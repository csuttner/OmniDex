//
//  Preview+Conversation.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import UIKit

enum Mock {
    
    static let serviceProvider = ServiceProvider(chatService: MockChatService())
    
    static let storeProvider = StoreProvider(
        conversationStore: MockConversationStore(),
        userStore: MockUserStore()
    )
    
    static var conversation: Conversation {
        let messages = messageContent.map { index, text, image in
            Message(
                date: Date() + Double(index),
                isUser: (index % 2 != 0),
                text: text,
                image: image
            )
        }
        
        return Conversation(
            messages: messages,
            updated: Date(),
            summary: "Preview conversation summary here"
        )
    }
    
    private static var lamboImageString: String? {
        UIImage(named: "Lambo")!.base64String
    }

    static var messageWithImage = Message(text: MockConstants.nearbyLocations, image: lamboImageString)

    static var messageContent: [(index: Int, String, image: String?)] {
        [
            (0, MockConstants.glad, nil),
            (1, MockConstants.nearbyLocations, nil),
            (2, MockConstants.glad, nil),
            (3, MockConstants.nearbyLocations, nil),
            (4, MockConstants.glad, nil),
            (5, MockConstants.nearbyLocations, nil),
            (6, MockConstants.glad, nil),
            (7, MockConstants.nearbyLocations, nil),
            (8, MockConstants.no, nil),
            (9, MockConstants.nearbyLocations, nil),
            (10, MockConstants.glad, nil),
            (11, MockConstants.nearbyLocations, nil),
            (12, MockConstants.glad, nil),
            (13, MockConstants.nearbyLocations, nil),
            (14, MockConstants.glad, nil),
            (15, MockConstants.nearbyLocations, nil),
            (16, MockConstants.glad, nil),
            (17, MockConstants.longResponse, image: lamboImageString),
        ]
    }
}
