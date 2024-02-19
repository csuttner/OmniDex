//
//  ChatCompletionChoice.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

public struct ChatCompletionChoice: Decodable {
    public let index: Int
    public let delta: OpenAIChatMessage?
    public let message: OpenAIChatMessage?
    public let logprobs: String?
    public let finishReason: String?

    public init(index: Int = 0, delta: OpenAIChatMessage? = nil, message: OpenAIChatMessage? = nil, logprobs: String? = nil, finishReason: String? = nil) {
        self.index = index
        self.delta = delta
        self.message = message
        self.logprobs = logprobs
        self.finishReason = finishReason
    }
}
