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
            Spacer()
            
            LazyVStack {
                ForEach(viewModel.chatMessages) { chatMessage in
                    ChatMessageView(
                        viewModel: ChatMessageViewModel(
                            chatMessage: chatMessage
                        )
                    )
                }
            }
            
            TextField(Constants.Chat.sendAMessage, text: $viewModel.prompt)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onSubmit {
                    viewModel.submit()
                }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: Mocks.chatViewModel)
    }
}
