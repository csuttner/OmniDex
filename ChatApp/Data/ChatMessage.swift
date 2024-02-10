//
//  ChatMessage.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

struct ChatMessage: Identifiable {
    let id: String
    let date: Date
    let sender: MessageSender
    let content: String
    let isLoading: Bool
    
    static let loadingMessage = ChatMessage(
        id: "",
        date: Date(),
        sender: MessageSender(role: .assistant),
        content: "",
        isLoading: true
    )
    
    var aiChatMessage: OpenAI.ChatMessage {
        OpenAI.ChatMessage(role: sender.role, content: content)
    }
    
    init(
        id: String,
        date: Date,
        sender: MessageSender,
        content: String,
        isLoading: Bool = true
    ) {
        self.id = id
        self.date = date
        self.sender = sender
        self.content = content
        self.isLoading = isLoading
    }
    
    init(replyResponse: ChatCompletionResponse) {
        id = replyResponse.id
        date = replyResponse.created

        let message = replyResponse.choices.first?.message

        sender = MessageSender(role: message?.role ?? .assistant)
        content = message?.content ?? ""
        isLoading = false
    }
}
