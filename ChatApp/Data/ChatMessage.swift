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
        sender: MessageSender(role: .assistant),
        isLoading: true
    )
    
    var aiChatMessage: OpenAI.ChatMessage {
        OpenAI.ChatMessage(role: sender.role, content: content)
    }
    
    init(
        id: String = UUID().uuidString,
        date: Date = Date(),
        sender: MessageSender,
        content: String = "",
        isLoading: Bool = false
    ) {
        self.id = id
        self.date = date
        self.sender = sender
        self.content = content
        self.isLoading = isLoading
    }
    
    init(
        id: String = UUID().uuidString,
        date: Date = Date(),
        role: Role,
        content: String = "",
        isLoading: Bool = false
    ) {
        self.id = id
        self.date = date
        sender = MessageSender(role: role)
        self.content = content
        self.isLoading = isLoading
    }
    
    init(response: ChatCompletionResponse) {
        id = response.id
        date = response.created

        let message = response.choices.first?.message

        sender = MessageSender(role: message?.role ?? .assistant)
        content = message?.content ?? ""
        isLoading = false
    }
}

extension ChatMessage: Equatable {
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        lhs.id == rhs.id
    }
}
