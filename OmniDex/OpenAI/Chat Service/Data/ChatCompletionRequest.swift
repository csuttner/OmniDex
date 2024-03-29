//
//  ChatCompletionRequest.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

struct ChatCompletionRequest: Encodable {
    let messages: [OpenAIChatMessage]
    let model: AIModel
    let maxTokens: Int?
    let stream: Bool?

    init(messages: [OpenAIChatMessage], model: AIModel, maxTokens: Int? = nil, stream: Bool? = nil) {
        self.messages = messages
        self.model = model
        self.maxTokens = maxTokens
        self.stream = stream
    }
}
