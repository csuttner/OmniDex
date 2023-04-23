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
    
    init(chatResponse: AIChatResponse) {
        id = chatResponse.id
        date = chatResponse.created
        sender = MessageSender(role: chatResponse.role)
        content = chatResponse.choices.first?.message.content ?? ""
    }
}
