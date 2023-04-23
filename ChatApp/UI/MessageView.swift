//
//  MessageView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject var viewModel: MessageViewModel
    
    var body: some View {
        HStack {
            Image(systemName: viewModel.imageName)
            
            if viewModel.isLoading {
                Text(viewModel.content)
            } else {
                EllipsesLoadingView()
            }
        }
    }
}


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(
            viewModel: MessageViewModel(
                chatMessage: ChatMessage(
                    id: "",
                    date: Date(),
                    sender: MessageSender(role: .user),
                    content: ""
                )
            )
        )
    }
}
