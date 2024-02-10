//
//  ChatCompletionResponse.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public struct ChatCompletionResponse: Decodable {
    public let id: String
    public let choices: [ChatCompletionChoice]
    public let created: Date
    public let model: String
    public let systemFingerprint: String?
    public let object: String
    public let usage: ChatUsage
    
    var messages: [ChatMessage] {
        choices.compactMap(\.message)
    }
}

public struct ChatUsage: Decodable {
    public let promptTokens: Int
    public let completionTokens: Int
    public let totalTokens: Int
}
