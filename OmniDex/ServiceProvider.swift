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
    
    init(chatService: ChatService) {
        self.chatService = chatService
    }
}

