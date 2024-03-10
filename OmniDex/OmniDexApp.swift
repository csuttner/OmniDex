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
    
    let serviceProvider: ServiceProvider = {
        let service = OpenAISwift.ChatService()
        OpenAISwift.Auth.apiKey = Secrets.apiKey
        return ServiceProvider(chatService: service)
    }()
    
    let storeProvider: StoreProvider = {
        let dataStore = SwiftDataStore()!
        return StoreProvider(
            conversationStore: dataStore,
            userStore: dataStore
        )
    }()
    
    var body: some Scene {
        WindowGroup {
            ConversationRootView()
                .environment(serviceProvider)
                .environment(storeProvider)
        }
    }
}
