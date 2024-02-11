//
//  ChatUserCircle.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct ChatUserCircle: View {
    let imageName: String
    let style: ChatMessageStyle

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: style.minHeight, height: style.minHeight)
            .foregroundColor(style.accentColor)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(style.accentColor, lineWidth: style.lineWidth)
            )
    }
}

#Preview {
    ChatUserCircle(imageName: "Clay", style: ChatMessageStyle(isUser: true))
}
