//
//  ChatResponse.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

struct ChatResponse: Decodable {
    let id: String
    let object: String
    let created: Int
    let choices: [ChatChoice]
    let usage: ChatUsage
}

struct ChatChoice: Decodable {
    let index: Int
    let message: ChatMessage
    let finishReason: String
}

struct ChatUsage: Decodable {
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int
}
