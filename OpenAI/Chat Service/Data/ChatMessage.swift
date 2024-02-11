//
//  ChatMessage.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public struct ChatMessage: Codable {
    public let role: Role

    let content: ChatContent
    
    public var textContent: String? {
        switch content {
        case let .string(string):
            return string
        case let .array(array):
            return array.first { $0.type == .text }?.text
        }
    }
    
    public init(role: Role, content: String) {
        self.role = role
        self.content = .string(content)
    }
}
