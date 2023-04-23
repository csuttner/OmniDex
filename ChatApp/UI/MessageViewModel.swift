//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

class MessageViewModel: ObservableObject {
    @Published var isLoading: Bool
    @Published var content: String
    
    let imageName: String
    
    init(chatMessage: ChatMessage) {
        imageName = chatMessage.sender.imageName
        content = chatMessage.content
        isLoading = false
    }
}
