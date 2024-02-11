//
//  MessageSender.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

struct MessageSender {
    let role: Role
    
    var isUser: Bool {
        role == .user
    }
    
    var imageName: String {
        switch role {
        case .user:
            return "Clay"
        case .assistant:
            return "Robot"
        case .system:
            return "tv"
        }
    }
    
    init(role: Role) {
        self.role = role
    }
}
