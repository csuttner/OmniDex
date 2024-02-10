//
//  ChatView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    @FocusState private var promptIsFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(viewModel.chatMessages) { chatMessage in
                        ChatMessageView(
                            viewModel: ChatMessageViewModel(
                                chatMessage: chatMessage
                            )
                        )
                    }

                    if viewModel.isLoading {
                        ChatMessageView(viewModel: .loading)
                    }
                }
                .onReceive(viewModel.$chatMessages) { messages in
                    if let id = messages.last?.id {
                        proxy.scrollTo(id)
                        promptIsFocused = false
                    }
                }
            }
            
            TextField(Constants.Chat.sendAMessage, text: $viewModel.prompt)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(.regularMaterial)
                .focused($promptIsFocused)
                .onSubmit {
                    viewModel.submit()
                    promptIsFocused = false
                }
        }
        .alert(item: $viewModel.errorItem) { errorItem in
            Alert(
                title: Text(errorItem.title),
                message: Text(errorItem.message),
                dismissButton: .default(Text("OK")) {
                    viewModel.errorItem = nil
                }
            )
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: Mocks.chatViewModel)
    }
}
