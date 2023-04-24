//
//  MessageSender.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

struct MessageSender {
    let role: AIRole
    
    var isUser: Bool {
        role == .user
    }
    
    var imageName: String {
        switch role {
        case .user:
            return "person.circle"
        case .assistant:
            return "network"
        case .system:
            return "tv"
        }
    }
    
    init(role: AIRole) {
        self.role = role
    }
}
