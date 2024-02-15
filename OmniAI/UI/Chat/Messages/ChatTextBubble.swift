//
//  ChatTextBubble.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct ChatTextBubble: View {
    @Binding var text: String

    let isLoading: Bool
    let isUser: Bool

    var style: ChatMessageStyle {
        ChatMessageStyle(isUser: isUser)
    }

    var body: some View {
        HStack {
            if isLoading {
                EllipsesLoadingView()
            } else {
                Text(text)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.white)
            }
        }
        .frame(minHeight: style.minHeight)
        .padding([.top, .bottom], style.padding / 2)
        .padding([.leading, .trailing], style.padding)
        .background(
            MaskedCornerShape(cornerRadius: style.cornerRadius, isUser: isUser)
                .foregroundColor(style.accentColor)
                .opacity(0.5)
        )
        .overlay(
            MaskedCornerShape(cornerRadius: style.cornerRadius, isUser: isUser)
                .stroke(style.accentColor, lineWidth: style.lineWidth)
        )
    }
}

#Preview {
    ChatTextBubble(
        text: .constant(MockConstants.longResponse),
        isLoading: false,
        isUser: true
    )
}
