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
        let chatService = OpenAISwift.ChatService()
        let imageService = OpenAISwift.ImageService()
        
        OpenAISwift.Auth.apiKey = Secrets.apiKey
        
        return ServiceProvider(
            chatService: chatService,
            imageService: imageService
        )
    }()
    
    let storeProvider: StoreProvider = {
        let dataStore = SwiftDataStore()!

        return StoreProvider(
            conversationStore: dataStore,
            imageCreationStore: dataStore,
            userStore: dataStore
        )
    }()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(serviceProvider)
                .environment(storeProvider)
        }
    }
}
