//
//  MessageTextBubble.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct MessageTextBubble: View {
    var message: Message

    var style: MessageStyle {
        MessageStyle(isUser: message.isUser)
    }

    var body: some View {
        HStack {
            if message.isLoading {
                EllipsesLoadingView()
            } else {
                Text(message.text)
                    .textSelection(.enabled)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.white)
            }
        }
        .frame(minHeight: style.minHeight)
        .padding(.vertical, style.padding / 2)
        .padding(.horizontal, style.padding)
        .background(style.accentColor)
        .clipShape(style.clipShape)
        .onChange(of: message.text) {
            UIImpactFeedbackGenerator().impactOccurred()
        }
    }
}

#Preview {
    MessageTextBubble(message: Mock.messageWithImage)
}
