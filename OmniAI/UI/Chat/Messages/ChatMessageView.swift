//
//  ChatMessageView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct ChatMessageView: View {
    @ObservedObject var message: ChatMessage

    var style: ChatMessageStyle {
        ChatMessageStyle(isUser: message.sender.isUser)
    }

    var body: some View {
        VStack(alignment: message.sender.isUser ? .trailing : .leading, spacing: style.padding) {
            if
                let imageString = message.image,
                let image = UIImage.fromBase64(imageString)
            {
                ChatImageBubble(
                    image: image,
                    isUser: message.sender.isUser
                )
                .padding(message.sender.isUser ? .trailing : .leading, style.minHeight + style.padding)
            }

            HStack(alignment: .bottom, spacing: style.padding) {
                FlipGroup(if: message.sender.isUser) {
                    ChatUserCircle(
                        imageName: message.sender.imageName,
                        style: style
                    )

                    ChatTextBubble(
                        text: $message.text,
                        isLoading: message.isLoading,
                        isUser: message.sender.isUser
                    )
                }
            }
            .frame(
                maxWidth: .infinity,
                alignment: message.sender.isUser ? .trailing : .leading
            )
        }
        .padding([.leading, .trailing], style.padding * 2)
        .padding([.top, .bottom], style.padding)
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView(
            message: Mock.chatMessageWithImage
        )
        .padding()
    }
}
