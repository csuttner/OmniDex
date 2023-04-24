//
//  AIChatMessage.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public struct AIChatMessage: Codable {
    public let role: AIRole
    public let content: String
    
    public init(role: AIRole, content: String) {
        self.role = role
        self.content = content
    }
}
