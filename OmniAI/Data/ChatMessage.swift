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
    var text = ""
    var image: String?
    var isLoading = false

    static let loadingMessage = ChatMessage(
        role: .assistant,
        isLoading: true
    )

    var aiChatMessage: OpenAI.ChatMessage {
        OpenAI.ChatMessage(role: sender.role, text: text, image: image)
    }

    init(role: Role, isLoading: Bool) {
        sender = MessageSender(role: role)
        self.isLoading = isLoading
    }

    init(role: Role, text: String, image: String? = nil) {
        sender = MessageSender(role: role)
        self.text = text
        self.image = image
    }

    init(response: ChatCompletionResponse) {
        let message = response.choices.first?.message

        id = response.id
        date = response.created
        sender = MessageSender(role: message?.role ?? .assistant)
        text = message?.textContent ?? ""
        image = message?.imageContent ?? ""
    }
}

extension ChatMessage: Equatable {
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        lhs.id == rhs.id
    }
}
