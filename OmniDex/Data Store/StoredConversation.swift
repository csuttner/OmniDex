//
//  StoredConversation.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation
import SwiftData

@Model class StoredConversation {
    var id: String
    var messages: [StoredMessage]
    var updated: Date
    var summary: String
    
    var conversation: Conversation {
        Conversation(
            id: id,
            messages: messages.map(\.message).sorted { $0.date < $1.date },
            updated: updated,
            summary: summary
        )
    }
    
    init(conversation: Conversation) {
        self.id = conversation.id
        self.messages = conversation.messages.map(StoredMessage.init)
        self.updated = conversation.updated
        self.summary = conversation.summary
    }
}
