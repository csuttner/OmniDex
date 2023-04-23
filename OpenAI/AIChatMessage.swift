//
//  AIChatMessage.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

struct AIChatMessage: Codable {
    let role: AIRole
    let content: String
}
