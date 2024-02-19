//
//  ChatCompletionResponse+MockResponse.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

extension ChatCompletionResponse {
    static func mockResponse(message: OpenAIChatMessage) -> ChatCompletionResponse {
        ChatCompletionResponse(
            id: UUID().uuidString,
            choices: [
                ChatCompletionChoice(
                    index: 0,
                    delta: nil,
                    message: message,
                    logprobs: nil,
                    finishReason: nil
                ),
            ],
            created: Date(),
            model: "",
            systemFingerprint: nil,
            object: "",
            usage: ChatUsage(promptTokens: 0, completionTokens: 0, totalTokens: 0)
        )
    }
}
