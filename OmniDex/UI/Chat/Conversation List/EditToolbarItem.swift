//
//  EditToolbarItem.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import SwiftUI

struct EditToolbarItem: ToolbarContent {
    @Binding var config: ConversationRootConfig
    
    var body: some ToolbarContent {
        if config.editMode == .active {
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }

        } else {
            ToolbarItem(placement: .topBarLeading) {
                Menu {
                    Button {
                        config.editProfilePresented = true

                    } label: {
                        HStack {
                            Label(Constants.Common.profile, systemImage: "person.circle")
                        }
                    }
                    
                    Button {
                        config.editMode = .active

                    } label: {
                        Label(Constants.Chat.selectChats, systemImage: "checkmark.circle")
                    }

                } label: {
                    Text(Constants.Common.edit)
                }
            }
        }
    }
}
