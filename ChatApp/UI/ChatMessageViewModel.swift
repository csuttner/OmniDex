//
//  ChatMessageViewModel.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

struct ChatMessageViewModel {
    let isLoading: Bool
    let content: String
    let imageName: String
    let isUser: Bool
    
    init(chatMessage: ChatMessage) {
        isLoading = chatMessage.isLoading
        content = chatMessage.content
        imageName = chatMessage.sender.imageName
        isUser = chatMessage.sender.isUser
    }
}

