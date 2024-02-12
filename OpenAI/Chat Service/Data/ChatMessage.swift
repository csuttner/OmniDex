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
    
    public var imageContent: String? {
        guard case let .array(array) = content else {
            return nil
        }

        return array.first { $0.type == .image }?.imageUrl?.url
    }
    
    public init(role: Role, text: String, image: String? = nil) {
        self.role = role
        
        if let image, !image.isEmpty {
            self.content = .array([
                ChatContentItem(text: text),
                ChatContentItem(image: image)
            ])

        } else {
            self.content = .string(text)
        }
    }
}
