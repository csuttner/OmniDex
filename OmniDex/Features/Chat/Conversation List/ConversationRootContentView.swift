//
//  ConversationRootContentView.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/6/24.
//

import SwiftUI

struct ConversationRootContentView: View {
    var conversations: [Conversation]
    
    @Binding var config: ConversationRootConfig
    
    @State private var query = ""
    
    private var results: [Conversation] {
        query.isEmpty ? conversations : conversations.filter {
            $0.messages.map(\.text).joined().contains(query) ||
            $0.summary?.contains(query) == true
        }
    }
    
    var body: some View {
        if conversations.isEmpty {
            ContentUnavailableView(
                "Tap new to start a conversation",
                systemImage: "plus.message"
            )
            .symbolRenderingMode(.multicolor)

        } else {
            VStack {
                if results.isEmpty {
                    ContentUnavailableView(
                        "No search results for \(query)",
                        systemImage: "rectangle.and.text.magnifyingglass"
                    )
                    .symbolRenderingMode(.multicolor)
                    
                } else {
                    ConversationListView(
                        results: results,
                        config: $config
                    )
                }
            }
            .searchable(text: $query)
        }
    }
}

#Preview {
    ConversationRootContentView(
        conversations: [Mock.conversation, Mock.conversation, Mock.conversation],
        config: .constant(ConversationRootConfig())
    )
}
