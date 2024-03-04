//
//  ConversationScrollView.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct ConversationScrollView: View {
    @Environment(Conversation.self) private var conversation
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(conversation.messages) { message in
                        MessageView(message: message)
                    }
                }
                .padding(.bottom, 60)
            }
            .onChange(of: conversation.messages) { _, messages in
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
    ConversationScrollView()
        .environment(Mock.conversation)
}
