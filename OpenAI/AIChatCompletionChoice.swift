//
//  AIChatCompletionChoice.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

public struct AIChatCompletionChoice: Decodable {
    public let index: Int
    public let delta: AIChatMessage?
    public let message: AIChatMessage?
    public let logprobs: String?
    public let finishReason: String?
}
