//
//  ChatStreamView.swift
//  OmniAI
//
//  Created by Clay Suttner on 2/14/24.
//

import SwiftUI

struct ChatStreamView: View {
    @StateObject var viewModel: ChatStreamViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            ChatScrollView(chatMessages: $viewModel.chatMessages)

            ChatInputBar(
                text: $viewModel.text,
                selectedImage: $viewModel.image
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

#Preview {
    ChatStreamView(viewModel: ChatStreamViewModel(chatService: MockChatService()))
}
