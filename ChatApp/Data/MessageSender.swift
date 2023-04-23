//
//  MessageSender.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

struct MessageSender {
    let imageName: String
    let isUser: Bool
    
    init(role: AIRole) {
        switch role {
        case .user:
            imageName = "person.circle"
        case .assistant:
            imageName = "network"
        case .system:
            imageName = "tv"
        }
        
        isUser = role == .user
    }
}
