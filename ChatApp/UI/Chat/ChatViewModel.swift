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
    
    private var promptMessage: ChatMessage {
        ChatMessage(
            id: UUID().uuidString,
            date: Date(),
            sender: .init(role: .user),
            content: prompt,
            isLoading: false
        )
    }
    
    init(chatMessages: [ChatMessage], prompt: String) {
        self.chatMessages = chatMessages
        self.prompt = prompt
    }
    
    func submit() {
        let history = chatMessages.map(\.aiChatMessage)
        chatMessages.append(promptMessage)
        chatMessages.append(.loadingMessage)
        
        Task.init {
            do {
                let response = try await APIService.shared.fetchChatCompletion(
                    prompt: prompt,
                    history: history
                )
                
                DispatchQueue.main.async { [weak self] in
                    self?.prompt = ""
                    self?.chatMessages.removeAll { $0.isLoading }
                    self?.chatMessages.append(ChatMessage(replyResponse: response))
                }

            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.errorItem = ErrorItem(error: error)
                }
            }
        }
    }
}
