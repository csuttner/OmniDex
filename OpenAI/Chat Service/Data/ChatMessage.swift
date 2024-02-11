//
//  ChatMessage.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public struct ChatMessage: Codable {
    public let role: Role
    public let content: String
    
    public init(role: Role, content: String) {
        self.role = role
        self.content = content
    }
}
