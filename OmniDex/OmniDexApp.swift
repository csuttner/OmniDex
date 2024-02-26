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
    @State private var chatViewModel = ChatViewModel(chatService: ServiceProvider.openAiChatService)
    
    var body: some Scene {
        WindowGroup {
            ChatView()
                .environment(chatViewModel)
        }
    }
}

class ServiceProvider {
    static let openAiChatService: ChatService = {
        let service = OpenAISwift.ChatService()
        OpenAISwift.Auth.apiKey = Secrets.apiKey
        return service
    }()
}
