//
//  ChatImageBubble.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import SwiftUI

struct MessageImageBubble: View {
    let image: UIImage
    let isUser: Bool

    var style: MessageStyle {
        MessageStyle(isUser: isUser)
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style.accentColor)
            )
    }
}

#Preview {
    MessageImageBubble(
        image: UIImage(named: "Lambo")!,
        isUser: true
    )
}
