//
//  AIChatResponse.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

struct AIChatResponse: Decodable {
    let id: String
    let object: String
    let created: Date
    let choices: [AIChatChoice]
    let usage: AIChatUsage
}

struct AIChatChoice: Decodable {
    let index: Int
    let message: AIChatMessage
    let finishReason: String
}

struct AIChatUsage: Decodable {
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int
}
