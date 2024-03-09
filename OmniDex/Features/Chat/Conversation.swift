//
//  ChatStreamViewModel.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import Observation

@Observable class Conversation: Identifiable, Hashable {
    var id: String
    var messages: [Message]
    var updated: Date
    var summary: String?
    
    init(
        id: String = UUID().uuidString,
        messages: [Message] = [Message](),
        updated: Date = Date(),
        summary: String? = nil
    ) {
        self.id = id
        self.messages = messages
        self.updated = updated
        self.summary = summary
    }
    
    func matches(_ query: String) -> Bool {
        messages
            .map { $0.text.lowercased() }
            .joined()
            .appending(summary ?? "")
            .contains(query.lowercased())
    }

    static func ==(lhs: Conversation, rhs: Conversation) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
