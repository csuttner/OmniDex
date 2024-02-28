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
                    .textSelection(.enabled)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.white)
            }
        }
        .frame(minHeight: style.minHeight)
        .padding(.vertical, style.padding / 2)
        .padding(.horizontal, style.padding)
        .background(
            MaskedCornerShape(cornerRadius: style.cornerRadius, isUser: isUser)
                .foregroundColor(style.accentColor)
                .opacity(0.5)
        )
        .overlay(
            MaskedCornerShape(cornerRadius: style.cornerRadius, isUser: isUser)
                .stroke(style.accentColor, lineWidth: style.lineWidth)
        )
        .onChange(of: text) {
            UIImpactFeedbackGenerator().impactOccurred()
        }
    }
}

#Preview {
    ChatTextBubble(
        text: .constant(MockConstants.longResponse),
        isLoading: false,
        isUser: true
    )
}
