//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

class MessageViewModel: ObservableObject {
    @Published var isLoading: Bool
    @Published var content: String
    
    let imageName: String
    
    init(chatMessage: ChatMessage) {
        imageName = chatMessage.role.imageName
        content = chatMessage.content
        isLoading = false
    }
    
    init() {
        imageName = OpenAIRole.assistant.imageName
        content = ""
        isLoading = true
    }
}
