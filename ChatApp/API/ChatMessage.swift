//
//  ChatMessage.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

struct ChatMessage: Codable {
    let role: OpenAIRole
    let content: String
}
