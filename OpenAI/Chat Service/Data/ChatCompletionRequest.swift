//
//  ChatCompletionRequest.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

struct ChatCompletionRequest: Encodable {
    let messages: [ChatMessage]
    let model: AIModel
    let maxTokens = 1000

    init(messages: [ChatMessage]) {
        self.messages = messages

        model = .gpt4VisionPreview
    }
}
