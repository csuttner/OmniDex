//
//  Preview+Conversation.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import SwiftData
import SwiftUI

extension Preview {
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

    static var messageWithImage = Message(text: PreviewConstants.nearbyLocations, image: lamboImageString)

    static var messageContent: [(index: Int, String, image: String?)] {
        [
            (0, PreviewConstants.glad, nil),
            (1, PreviewConstants.nearbyLocations, nil),
            (2, PreviewConstants.glad, nil),
            (3, PreviewConstants.nearbyLocations, nil),
            (4, PreviewConstants.glad, nil),
            (5, PreviewConstants.nearbyLocations, nil),
            (6, PreviewConstants.glad, nil),
            (7, PreviewConstants.nearbyLocations, nil),
            (8, PreviewConstants.no, nil),
            (9, PreviewConstants.nearbyLocations, nil),
            (10, PreviewConstants.glad, nil),
            (11, PreviewConstants.nearbyLocations, nil),
            (12, PreviewConstants.glad, nil),
            (13, PreviewConstants.nearbyLocations, nil),
            (14, PreviewConstants.glad, nil),
            (15, PreviewConstants.nearbyLocations, nil),
            (16, PreviewConstants.glad, nil),
            (17, PreviewConstants.nearbyLocations, image: lamboImageString),
        ]
    }
}
