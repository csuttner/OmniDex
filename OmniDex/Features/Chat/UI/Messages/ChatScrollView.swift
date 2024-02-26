//
//  ChatScrollView.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct ChatScrollView: View {
    @Binding var messages: [Message]

    var body: some View {
        ScrollViewReader { proxy in
            KeyboardDismissableScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(messages) { message in
                        ChatMessageView()
                            .environment(message)
                    }
                }
                .padding(.bottom, 60)
            }
            .onChange(of: messages) { _, messages in
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
    ChatScrollView(messages: .constant(Mock.chatMessages))
}
