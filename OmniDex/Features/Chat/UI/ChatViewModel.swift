//
//  ChatStreamViewModel.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import UIKit

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [Message]
    @Published var text: String
    @Published var image: UIImage?
    @Published var errorItem: ErrorItem?

    private let chatService: ChatService

    init(
        chatService: ChatService,
        chatMessages: [Message] = [],
        prompt: String = ""
    ) {
        self.chatService = chatService
        self.messages = chatMessages
        text = prompt
    }

    func submit() {
        let newMessage = Message(
            text: text,
            image: image?.base64String
        )
        
        let history = messages

        text = ""
        image = nil
        messages.append(newMessage)
        messages.append(Message(isUser: false, isLoading: true))

        Task {
            do {
                let stream = try await chatService.streamChatCompletion(
                    text: newMessage.text,
                    image: newMessage.image,
                    history: history
                )
                
                for try await chunk in stream {
                    updateMessage(with: chunk)
                }

            } catch {
                handle(error: error, newMessage: newMessage)
            }
        }
    }

    private func updateMessage(with chunk: MessageChunk) {
        if let index = messages
            .firstIndex(where: { $0.id == chunk.id }) {
            messages[index].text.append(chunk.text)

        } else {
            messages.removeAll { $0.isLoading }
            messages.append(chunk.message)
        }
    }

    private func handle(error: Error, newMessage: Message) {
        messages.removeAll { $0.isLoading }
        messages.removeAll { $0 == newMessage }
        errorItem = ErrorItem(error: error)
        text = newMessage.text
        image = UIImage.fromBase64(newMessage.image)
    }
}
