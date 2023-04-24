//
//  AIReplyResponse.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public struct AIReplyResponse: Decodable {
    public let id: String
    public let object: String
    public let created: Date
    public let choices: [AIReplyChoice]
    public let usage: AIChatUsage
    
    var messages: [AIChatMessage] {
        choices.map(\.message)
    }
}

public struct AIReplyChoice: Decodable {
    public let index: Int
    public let message: AIChatMessage
    public let finishReason: String
}

public struct AIChatUsage: Decodable {
    public let promptTokens: Int
    public let completionTokens: Int
    public let totalTokens: Int
}
