//
//  StoredMessage.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation
import SwiftData

@Model class StoredMessage {
    @Attribute(.unique) let id: String
    let date: Date
    let isUser: Bool
    var text: String
    var image: String?
    
    var conversation: StoredConversation?
    
    var message: Message {
        Message(
            id: id,
            date: date,
            isUser: isUser,
            text: text,
            image: image
        )
    }
    
    init(message: Message) {
        self.id = message.id
        self.date = message.date
        self.isUser = message.isUser
        self.text = message.text
        self.image = message.image
    }
}
