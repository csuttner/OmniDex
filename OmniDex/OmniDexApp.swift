//
//  OmniDexApp.swift
//  OmniDex
//
//  Created by Clay Suttner on 4/23/23.
//

import OpenAI
import SwiftUI

@main
struct OmniDexApp: App {
    var body: some Scene {
        WindowGroup {
//            Mock.chatStreamView
//            ChatView(viewModel: ChatViewModel(chatService: OpenAIChatService()))
            ChatView(viewModel: ChatViewModel(chatService: OpenAIChatService()))
        }
    }
}
