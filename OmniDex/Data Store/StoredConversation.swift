//
//  StoredConversation.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation
import SwiftData

@Model class StoredConversation {
    @Attribute(.unique) let id: String
    var updated: Date
    var summary: String?
    
    @Relationship(deleteRule: .cascade, inverse: \StoredMessage.conversation)
    var messages: [StoredMessage]

    var conversation: Conversation {
        Conversation(
            id: id,
            messages: messages.map(\.message).sorted { $0.date < $1.date },
            updated: updated,
            summary: summary
        )
    }
    
    init(id: String, updated: Date, summary: String? = nil, messages: [StoredMessage] = []) {
        self.id = id
        self.updated = updated
        self.summary = summary
        self.messages = messages
    }
}
