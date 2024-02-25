//
//  ChatMessage.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAISwift

class Message: ObservableObject, Identifiable {
    @Published var text = ""

    var id = UUID().uuidString
    var date = Date()
    var sender: MessageSender
    var image: String?
    var isLoading = false

    static let loadingMessage = Message(
        role: .assistant,
        isLoading: true
    )

    var remoteMessage: OpenAISwift.Message {
        OpenAISwift.Message(
            role: sender.role,
            text: text,
            image: image
        )
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

    init(response: CompletionResponse) {
        let message = response.choices.first?.message

        id = response.id
        date = response.created
        sender = MessageSender(role: message?.role ?? .assistant)
        text = message?.textContent ?? ""
        image = message?.imageContent ?? ""
    }
    
    init(chunk: CompletionChunk) {
        let message = chunk.choices.first?.delta
        
        id = chunk.id
        date = chunk.created
        sender = MessageSender(role: message?.role ?? .assistant)
        text = message?.textContent ?? ""
    }
}

extension Message: Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
}
