//
//  ChatMessage.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

struct ChatMessage: Identifiable {
    var id = UUID().uuidString
    var date = Date()
    var sender: MessageSender
    var content = ""
    var isLoading = false
    
    static let loadingMessage = ChatMessage(
        role: .assistant,
        isLoading: true
    )
    
    var aiChatMessage: OpenAI.ChatMessage {
        OpenAI.ChatMessage(role: sender.role, content: content)
    }
    
    init(role: Role, isLoading: Bool) {
        sender = MessageSender(role: role)
        self.isLoading = isLoading
    }
    
    init(role: Role, content: String) {
        sender = MessageSender(role: role)
        self.content = content
    }
    
    init(response: ChatCompletionResponse) {
        let message = response.choices.first?.message

        id = response.id
        date = response.created
        sender = MessageSender(role: message?.role ?? .assistant)
        content = message?.textContent ?? ""
    }
}

extension ChatMessage: Equatable {
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        lhs.id == rhs.id
    }
}
