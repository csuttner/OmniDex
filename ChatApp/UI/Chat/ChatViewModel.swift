//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import UIKit
import Foundation
import OpenAI

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
        self.text = prompt
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
        DispatchQueue.main.async { [weak self] in
            self?.chatMessages.removeAll { $0.isLoading }
            self?.chatMessages.append(ChatMessage(response: response))
        }
    }
    
    private func handle(error: Error, newMessage: ChatMessage) {
        DispatchQueue.main.async { [weak self] in
            self?.chatMessages.removeAll { $0.isLoading }
            self?.chatMessages.removeAll { $0 == newMessage }
            self?.errorItem = ErrorItem(error: error)
            self?.text = newMessage.text
            self?.image = UIImage.fromBase64(newMessage.image) 
        }
    }
}
