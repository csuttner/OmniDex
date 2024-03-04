//
//  ConversationListRow.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/28/24.
//

import SwiftUI

struct ConversationListRow: View {
    let conversation: Conversation
    
    var body: some View {
        HStack {
            Text(conversation.updated.formatted(date: .abbreviated, time: .shortened))
            Text(conversation.summary)
        }
    }
}

#Preview {
    ConversationListRow(conversation: Mock.conversation)
}
