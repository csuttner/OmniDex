//
//  ChatTextBubble.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct ChatTextBubble: View {
    let isLoading: Bool
    let content: String
    let isUser: Bool

    var style: ChatMessageStyle {
        ChatMessageStyle(isUser: isUser)
    }

    var body: some View {
        HStack {
            if isLoading {
                EllipsesLoadingView()
            } else {
                Text(content)
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
        isLoading: false,
        content: MockConstants.longResponse,
        isUser: true
    )
}
