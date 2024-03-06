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
        VStack(alignment: .leading) {
            HStack {
                Text(conversation.summary ?? Constants.Chat.noSummary)
                    .lineLimit(1)
                    .font(.body)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text(dateTimeText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Image(systemName: "chevron.right")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.tertiary)
            }
            
            Text(conversation.messages.last?.text ?? "")
                .font(.subheadline)
                .lineLimit(2, reservesSpace: true)
                .foregroundStyle(.secondary)
        }
    }
    
    private var dateTimeText: String {
        let updated = conversation.updated
        let isToday = Calendar.current.isDateInToday(updated)

        return updated.formatted(
            date: isToday ? .omitted : .abbreviated,
            time: isToday ? .shortened : .omitted
        )
    }
}

#Preview {
    ConversationListRow(conversation: Mock.conversation)
}
