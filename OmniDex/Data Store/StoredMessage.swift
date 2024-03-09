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
    @Attribute(.externalStorage) var image: Data?
    
    var conversation: StoredConversation?
    
    var message: Message {
        Message(
            id: id,
            date: date,
            isUser: isUser,
            text: text,
            image: image?.base64EncodedString()
        )
    }
    
    init(message: Message) {
        self.id = message.id
        self.date = message.date
        self.isUser = message.isUser
        self.text = message.text
        
        if let image = message.image {
            self.image = Data(base64Encoded: image)
        } else {
            self.image = nil
        }
    }
}
