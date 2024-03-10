//
//  StoredConversation.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation
import SwiftData

@Model class StoredConversation {
    @Attribute(.unique) let localID: String
    var date: Date
    var summary: String?
    
    @Relationship(deleteRule: .cascade, inverse: \StoredMessage.conversation)
    var messages: [StoredMessage]

    var conversation: Conversation {
        Conversation(
            id: localID,
            messages: messages.map(\.message).sorted { $0.date < $1.date },
            updated: date,
            summary: summary
        )
    }
    
    init(localID: String, date: Date, summary: String? = nil, messages: [StoredMessage] = []) {
        self.localID = localID
        self.date = date
        self.summary = summary
        self.messages = messages
    }
}
