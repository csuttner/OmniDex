//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import OpenAI
import SwiftUI

@main
struct ChatAppApp: App {
    var body: some Scene {
        WindowGroup {
            ChatView(viewModel: ChatViewModel(chatService: OpenAIChatService()))
        }
    }
}
