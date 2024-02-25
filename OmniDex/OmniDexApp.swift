//
//  OmniDexApp.swift
//  OmniDex
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI
import OpenAISwift

@main
struct OmniDexApp: App {
    let chatService: ChatService = {
        let service = OpenAISwift.ChatService()
        OpenAISwift.Auth.apiKey = Secrets.apiKey
        return service
    }()
    
    var body: some Scene {
        WindowGroup {
            ChatView(viewModel: ChatViewModel(chatService: chatService))
        }
    }
}
