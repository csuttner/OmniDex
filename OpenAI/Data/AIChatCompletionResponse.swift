//
//  AIChatCompletionResponse.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public struct AIChatCompletionResponse: Decodable {
    public let id: String
    public let choices: [AIChatCompletionChoice]
    public let created: Date
    public let model: String
    public let systemFingerprint: String?
    public let object: String
    public let usage: AIChatUsage
    
    var messages: [AIChatMessage] {
        choices.compactMap(\.message)
    }
}

public struct AIChatUsage: Decodable {
    public let promptTokens: Int
    public let completionTokens: Int
    public let totalTokens: Int
}
