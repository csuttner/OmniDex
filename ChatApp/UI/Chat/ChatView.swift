//
//  ChatView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    @State private var selectedImage: UIImage?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ChatScrollView(chatMessages: $viewModel.chatMessages)

            ChatInputBar(
                selectedImage: $selectedImage,
                text: $viewModel.prompt
            ) {
                viewModel.submit()
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
        ChatView(viewModel: Mock.chatViewModel)
    }
}
