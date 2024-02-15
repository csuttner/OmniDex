//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI
import UIKit

@MainActor
class ChatViewModel: ObservableObject {
    @Published var chatMessages: [ChatMessage]
    @Published var text: String
    @Published var image: UIImage?
    @Published var errorItem: ErrorItem?

    private let chatService: ChatService

    init(
        chatService: ChatService,
        chatMessages: [ChatMessage] = [],
        prompt: String = ""
    ) {
        self.chatService = chatService
        self.chatMessages = chatMessages
        text = prompt
    }

    func submit() {
        let newMessage = ChatMessage(
            role: .user,
            text: text,
            image: image?.base64String
        )

        let history = chatMessages.map(\.aiChatMessage)

        text = ""
        image = nil
        chatMessages.append(newMessage)
        chatMessages.append(.loadingMessage)

        Task.init {
            do {
                let response = try await chatService.fetchChatCompletion(
                    text: newMessage.text,
                    image: newMessage.image,
                    history: history
                )

                handle(response: response)
            } catch {
                handle(error: error, newMessage: newMessage)
            }
        }
    }

    private func handle(response: ChatCompletionResponse) {
        chatMessages.removeAll { $0.isLoading }
        chatMessages.append(ChatMessage(response: response))
    }

    private func handle(error: Error, newMessage: ChatMessage) {
        chatMessages.removeAll { $0.isLoading }
        chatMessages.removeAll { $0 == newMessage }
        errorItem = ErrorItem(error: error)
        text = newMessage.text
        image = UIImage.fromBase64(newMessage.image)
    }
}
