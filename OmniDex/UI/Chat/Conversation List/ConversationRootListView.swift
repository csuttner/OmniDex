//
//  ConversationRootListView.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/6/24.
//

import SwiftUI

struct ConversationRootListView: View {
    var results: [Conversation]
    
    @Binding var config: ConversationRootConfig
    
    var body: some View {
        List(results, id: \.id, selection: $config.selection) { conversation in
            Button {
                config.path.append(conversation)
            } label: {
                ConversationRootListRow(conversation: conversation)
            }
            .swipeActions(edge: .trailing) {
                Button() {
                    config.deleteSelection = Set([conversation.id])
                } label: {
                    Label(Constants.Common.delete, systemImage: "trash")
                }
                .tint(.red)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ConversationRootListView(
        results: [Mock.conversation],
        config: .constant(ConversationRootConfig())
    )
}
