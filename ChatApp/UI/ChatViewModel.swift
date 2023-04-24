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
    
    init(chatMessages: [ChatMessage], prompt: String) {
        self.chatMessages = chatMessages
        self.prompt = prompt
    }
    
    func submit() {
        let history = chatMessages.map(\.aiChatMessage)

        chatMessages.append(ChatMessage.loadingMessage)
        
        Task.init {
            do {
                let response = try await AIService.shared.submit(prompt: prompt, history: history)
                
                DispatchQueue.main.async { [weak self] in
                    self?.chatMessages.removeLast()
                    
                    self?.chatMessages.append(ChatMessage(replyResponse: response))
                }

            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
