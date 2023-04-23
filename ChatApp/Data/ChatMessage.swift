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
    
    init(id: String, date: Date, sender: MessageSender, content: String) {
        self.id = id
        self.date = date
        self.sender = sender
        self.content = content
    }
    
    init(chatResponse: AIChatResponse) {
        id = chatResponse.id
        date = chatResponse.created

        let message = chatResponse.choices.first?.message

        sender = MessageSender(role: message?.role ?? .assistant)
        content = message?.content ?? ""
    }
}
