//
//  ChatCompletionResponse+MockResponse.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation
import OpenAISwift

extension CompletionResponse {
    static func mockResponse(message: OpenAISwift.Message) -> CompletionResponse {
        CompletionResponse(
            id: UUID().uuidString,
            choices: [
                CompletionChoice(
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
            usage: Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0)
        )
    }
}
