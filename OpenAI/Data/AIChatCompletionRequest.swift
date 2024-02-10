//
//  AIChatCompletionRequest.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

struct AIChatCompletionRequest: Encodable {
    let messages: [AIChatMessage]
    let model: AILanguageModel
    
    init(messages: [AIChatMessage]) {
        self.messages = messages

        model = .gpt3_5Turbo
    }
}
