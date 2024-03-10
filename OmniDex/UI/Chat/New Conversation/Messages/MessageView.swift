//
//  MessageView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct MessageView: View {
    let userImage: UIImage?
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
                    
                    HStack {
                        FlipGroup(if: message.isUser) {
                            SmallImageCircle(userImage: userImage, style: style)
                            
                            Text(message.date.formatted(date: .omitted, time: .complete))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    MessageView(
        userImage: UIImage(named: "Clay")!,
        message: Mock.messageWithImage
    )
}
