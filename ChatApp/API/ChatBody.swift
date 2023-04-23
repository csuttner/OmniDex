//
//  ChatBody.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

struct ChatBody: Encodable {
    let model: OpenAIModel
    let messages: [ChatMessage]
    let temperature: Double?
    let topP: Double?
    let n: Int?
    let stream: Bool?
    let stop: [String]?
    let maxTokens: Int?
    let presencePenalty: Double?
    let logitBias: [String: Double]?
    let user: String?
    
    init(messages: [ChatMessage]) {
        self.messages = messages

        model = .gpt3_5Turbo
        temperature = nil
        topP = nil
        n = nil
        stream = nil
        stop = nil
        maxTokens = nil
        presencePenalty = nil
        logitBias = nil
        user = nil
    }
}
