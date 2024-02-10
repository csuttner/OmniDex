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
                KeyboardDismissableScrollView {
                    LazyVStack (alignment: .leading) {
                        ForEach(viewModel.chatMessages) { chatMessage in
                            ChatMessageView(
                                viewModel: ChatMessageViewModel(
                                    chatMessage: chatMessage
                                )
                            )
                        }
                    }
                }
                .onReceive(viewModel.$chatMessages) { messages in
                    withAnimation {
                        if let id = messages.last?.id {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
            }
            
            TextField(Constants.Chat.message, text: $viewModel.prompt)
                .textFieldStyle(PillTextFieldStyle())
                .padding()
                .submitLabel(.send)
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
