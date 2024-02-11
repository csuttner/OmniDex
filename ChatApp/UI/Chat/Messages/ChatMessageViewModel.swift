//
//  ChatMessageViewModel.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation
import OpenAI

struct ChatMessageViewModel {
    var isLoading = false
    var text = ""
    var senderImageName = ""
    var isUser = true
    var image: String?
    
    init(chatMessage: ChatMessage) {
        isLoading = chatMessage.isLoading
        text = chatMessage.content
        senderImageName = chatMessage.sender.imageName
        isUser = chatMessage.sender.isUser
    }
}

