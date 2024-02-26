//
//  ChatMessageView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct ChatMessageView: View {
    @Environment (Message.self) private var message

    var style: ChatMessageStyle {
        ChatMessageStyle(isUser: message.isUser)
    }

    var body: some View {
        @Bindable var bindable = message

        VStack(alignment: message.isUser ? .trailing : .leading, spacing: style.padding) {
            if
                let imageString = message.image,
                let image = UIImage.fromBase64(imageString) {
                ChatImageBubble(
                    image: image,
                    isUser: message.isUser
                )
                .padding(message.isUser ? .trailing : .leading, style.minHeight + style.padding)
            }

            HStack(alignment: .bottom, spacing: style.padding) {
                FlipGroup(if: message.isUser) {
                    ChatUserCircle(
                        imageName: message.imageName,
                        style: style
                    )

                    ChatTextBubble(
                        text: $bindable.text,
                        isLoading: message.isLoading,
                        isUser: message.isUser
                    )
                }
            }
            .frame(
                maxWidth: .infinity,
                alignment: message.isUser ? .trailing : .leading
            )
        }
        .padding(.horizontal, style.padding * 2)
        .padding(.vertical, style.padding)
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView()
            .environment(Mock.chatMessageWithImage)
            .padding()
    }
}
