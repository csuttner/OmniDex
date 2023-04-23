//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var chatMessages: [ChatMessage]
    
    init(chatMessages: [ChatMessage]) {
        self.chatMessages = chatMessages
    }
}

extension ChatViewModel {
    static let mock = ChatViewModel(
        chatMessages: []
    )
}
