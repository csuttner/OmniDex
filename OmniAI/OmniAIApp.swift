//
//  OmniAIApp.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import OpenAI
import SwiftUI

@main
struct OmniAIApp: App {
    var body: some Scene {
        WindowGroup {
//            Mock.chatStreamView
//            ChatView(viewModel: ChatViewModel(chatService: OpenAIChatService()))
            ChatStreamView(viewModel: ChatStreamViewModel(chatService: OpenAIChatService()))
        }
    }
}
