//
//  AIChatResponse.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public struct AIChatResponse: Decodable {
    public let id: String
    public let object: String
    public let created: Date
    public let choices: [AIChatChoice]
    public let usage: AIChatUsage
}

public struct AIChatChoice: Decodable {
    public let index: Int
    public let message: AIChatMessage
    public let finishReason: String
}

public struct AIChatUsage: Decodable {
    public let promptTokens: Int
    public let completionTokens: Int
    public let totalTokens: Int
}
