//
//  ChatMessage.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import Observation

@Observable class Message: Identifiable {
    let id: String
    var date: Date
    let isUser: Bool
    var text: String
    var image: String?
    var isLoading: Bool
    
    init(
        id: String = UUID().uuidString,
        date: Date = Date(),
        isUser: Bool = true,
        text: String = "",
        image: String? = nil,
        isLoading: Bool = false
    ) {
        self.id = id
        self.date = date
        self.isUser = isUser
        self.text = text
        self.image = image
        self.isLoading = isLoading
    }
}

extension Message: Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
}

extension Message: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
