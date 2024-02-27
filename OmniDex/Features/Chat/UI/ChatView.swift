//
//  ChatView.swift
//  OmniAI
//
//  Created by Clay Suttner on 2/14/24.
//

import SwiftUI

struct ChatView: View {
    @State private var chatModel = ChatModel(chatService: ServiceProvider.openAiChatService)

    var body: some View {
        @Bindable var bindable = chatModel

        ZStack(alignment: .bottom) {
            ChatScrollView(messages: $bindable.messages)

            ChatInputBar(
                text: $bindable.prompt,
                selectedImage: $bindable.image
            ) {
                chatModel.submit()
            }
        }
        .alert(item: $bindable.errorItem) { errorItem in
            Alert(
                title: Text(errorItem.title),
                message: Text(errorItem.message),
                dismissButton: .default(Text("OK")) {
                    chatModel.errorItem = nil
                }
            )
        }
    }
}

#Preview {
    ChatView()
}
