//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

class ChatViewModel: ObservableObject {
    @Published var chatMessages: [ChatMessage]
    @Published var prompt: String
    @Published var errorItem: ErrorItem?
    @Published var isLoading: Bool
    
    private var promptMessage: ChatMessage {
        ChatMessage(
            id: UUID().uuidString,
            date: Date(),
            sender: .init(role: .user),
            content: prompt
        )
    }
    
    init(chatMessages: [ChatMessage], prompt: String) {
        self.chatMessages = chatMessages
        self.prompt = prompt
        
        isLoading = false
    }
    
    func submit() {
        isLoading = true
        
        let history = chatMessages.map(\.aiChatMessage)
        chatMessages.append(promptMessage)
        chatMessages.append(ChatMessage.loadingMessage)
        
        Task.init {
            do {
                let response = try await AIService.shared.fetchChatCompletion(prompt: prompt, history: history)
                
                DispatchQueue.main.async { [weak self] in
                    self?.prompt = ""
                    self?.chatMessages.removeLast()
                    self?.chatMessages.append(ChatMessage(replyResponse: response))
                    self?.isLoading = false
                }

            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.errorItem = ErrorItem(error: error)
                    self?.isLoading = false
                }
            }
        }
    }
}
