//
//  ChatView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.chatMessages) { chatMessage in
                ChatMessageView(
                    viewModel: ChatMessageViewModel(
                        chatMessage: chatMessage
                    )
                )
            }
        }
        .padding()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: Mocks.chatViewModel)
    }
}
