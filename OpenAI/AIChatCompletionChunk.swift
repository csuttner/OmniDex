//
//  AIChatCompletionChunk.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

public struct AIChatCompletionChunk: Decodable {
    public let id: String
    public let object: String
    public let created: Int
    public let model: String
    public let systemFingerprint: String
    public let choices: [AIChatCompletionChoice]
}
