//
//  MessageSender.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

struct MessageSender {
    let image: String
    let isUser: Bool
    
    init(role: AIRole) {
        switch role {
        case .user:
            image = "person.circle"
        case .assistant:
            image = "network"
        case .system:
            image = "tv"
        }
        
        isUser = role == .user
    }
}
