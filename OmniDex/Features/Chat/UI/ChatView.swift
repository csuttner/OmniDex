//
//  ChatView.swift
//  OmniAI
//
//  Created by Clay Suttner on 2/14/24.
//

import SwiftUI

struct ChatView: View {
    @Environment(ChatViewModel.self) private var viewModel

    var body: some View {
        @Bindable var bindable = viewModel

        ZStack(alignment: .bottom) {
            ChatScrollView(messages: $bindable.messages)

            ChatInputBar(
                text: $bindable.prompt,
                selectedImage: $bindable.image
            ) {
                viewModel.submit()
            }
        }
        .alert(item: $bindable.errorItem) { errorItem in
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
    ChatView()
        .environment(ChatViewModel(chatService: MockChatService()))
}
