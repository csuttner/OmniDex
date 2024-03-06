//
//  MessageListView.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct MessageListView: View {
    @Environment(Conversation.self) private var conversation
    
    @Binding var lastMessage: Message?
    
    var body: some View {
        List(conversation.messages) { message in
            MessageView(message: message)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .scrollPosition(id: $lastMessage, anchor: .bottom)
        .padding(.bottom, 60)
    }
}

#Preview {
    MessageListView(lastMessage: .constant(nil))
        .environment(Mock.conversation)
}
