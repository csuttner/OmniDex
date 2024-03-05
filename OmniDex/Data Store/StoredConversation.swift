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
    
    func update(with conversation: Conversation) {
        let storedIds = Set(messages.map(\.id))
        let diff = conversation.messages.filter { !storedIds.contains($0.id) }
        
        print("message diff:", diff)

        messages.append(contentsOf: diff.map(StoredMessage.init))
        updated = diff.first?.date ?? updated
        summary = conversation.summary
    }
}
