//
//  NewConversationToolbarItem.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/6/24.
//

import SwiftUI

struct NewConversationToolbarItem: ToolbarContent {
    @Binding var path: [Conversation]
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                path.append(Conversation())
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text(Constants.Common.new)
                }
                .fontWeight(.semibold)
            }
        }
    }
}
