//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

@MainActor
class ChatViewModel: ObservableObject {
    @Published var chatMessages: [ChatMessage]
    @Published var prompt: String
    @Published var errorItem: ErrorItem?
    
    private var promptMessage: ChatMessage?
    
    init(chatMessages: [ChatMessage], prompt: String) {
        self.chatMessages = chatMessages
        self.prompt = prompt
    }
    
    func submit() {
        let promptMessage = makePromptMessage()
        let history = chatMessages.map(\.aiChatMessage)

        prompt = ""
        chatMessages.append(promptMessage)
        chatMessages.append(.loadingMessage)
        
        Task.init {
            do {
                let response = try await APIService.shared.fetchChatCompletion(
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
    
    private func makePromptMessage() -> ChatMessage {
        ChatMessage(
            id: UUID().uuidString,
            date: Date(),
            sender: .init(role: .user),
            content: prompt,
            isLoading: false
        )
    }
}
