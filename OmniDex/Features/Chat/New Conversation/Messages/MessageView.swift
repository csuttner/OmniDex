//
//  MessageView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct MessageView: View {
    var message: Message

    var style: MessageStyle {
        MessageStyle(isUser: message.isUser)
    }

    var body: some View {
        HStack {
            FlipGroup(if: message.isUser) {
                VStack(
                    alignment: message.isUser ? .trailing : .leading,
                    spacing: style.padding
                ) {
                    if
                        let imageString = message.image,
                        let image = UIImage.fromBase64(imageString) {
                        MessageImageBubble(
                            image: image,
                            isUser: message.isUser
                        )
                    }
                    
                    MessageTextBubble(message: message)
                    
                    UserPictureCircle(
                        imageName: message.imageName,
                        style: style
                    )
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, style.padding * 2)
        .padding(.vertical, style.padding)
    }
}

#Preview {
    MessageView(message: Mock.messageWithImage)
}
