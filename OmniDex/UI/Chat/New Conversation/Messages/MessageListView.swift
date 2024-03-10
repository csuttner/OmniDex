//
//  MessageListView.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct MessageListView: View {
    @Environment(Conversation.self) private var conversation
    
    @State private var lastMessage: Message?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(conversation.messages) { message in
                    MessageView(message: message)
                        .padding([.top, .leading, .trailing], 12)
                }
            }
            .padding(.bottom, 60)
            .scrollTargetLayout()
        }
        .defaultScrollAnchor(.bottom)
        .scrollPosition(id: $lastMessage, anchor: .bottom)
        .animation(.easeIn, value: conversation.messages)
        .onChange(of: conversation.messages) {
            lastMessage = conversation.messages.last
        }
    }
}

#Preview {
    MessageListView()
        .environment(Mock.conversation)
}
