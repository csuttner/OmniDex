//
//  ChatScrollView.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct ChatScrollView: View {
    @Binding var chatMessages: [ChatMessage]
    
    var body: some View {
        ScrollViewReader { proxy in
            KeyboardDismissableScrollView {
                LazyVStack (alignment: .leading) {
                    ForEach(chatMessages) { chatMessage in
                        ChatMessageView(
                            viewModel: ChatMessageViewModel(
                                chatMessage: chatMessage
                            )
                        )
                    }
                }
            }
            .onChange(of: chatMessages) { messages in
                withAnimation {
                    if let id = messages.last?.id {
                        proxy.scrollTo(id)
                    }
                }
            }
        }
    }
}

#Preview {
    ChatScrollView(chatMessages: .constant(Mock.chatMessages))
}
