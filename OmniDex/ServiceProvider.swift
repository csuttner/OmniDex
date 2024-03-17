//
//  ServiceProvider.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation
import Observation

@Observable class ServiceProvider {
    let chatService: ChatService
    let imageService: ImageService
    
    init(chatService: ChatService, imageService: ImageService) {
        self.chatService = chatService
        self.imageService = imageService
    }
}

