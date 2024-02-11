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
    @Published var prompt: String
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
        self.prompt = prompt
    }
    
    func submit() {
        let promptMessage = ChatMessage(role: .user, content: prompt)
        let history = chatMessages.map(\.aiChatMessage)

        prompt = ""
        chatMessages.append(promptMessage)
        chatMessages.append(.loadingMessage)
        
        Task.init {
            do {
                let response = try await chatService.fetchChatCompletion(
                    prompt: promptMessage.content,
                    history: history
                )

                handle(response: response)

            } catch {
                handle(error: error, promptMessage: promptMessage)
            }
        }
    }
    
    private func handle(response: ChatCompletionResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.chatMessages.removeAll { $0.isLoading }
            self?.chatMessages.append(ChatMessage(response: response))
        }
    }
    
    private func handle(error: Error, promptMessage: ChatMessage) {
        DispatchQueue.main.async { [weak self] in
            self?.chatMessages.removeAll { $0.isLoading }
            self?.chatMessages.removeAll { $0 == promptMessage }
            self?.errorItem = ErrorItem(error: error)
            self?.prompt = promptMessage.content
        }
    }
}
