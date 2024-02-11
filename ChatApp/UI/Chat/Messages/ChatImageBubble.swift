//
//  ChatImageBubble.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import SwiftUI

struct ChatImageBubble: View {
    let image: UIImage
    let isUser: Bool
    
    var style: ChatMessageStyle {
        ChatMessageStyle(isUser: isUser)
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
    ChatImageBubble(
        image: UIImage(named: "Lambo")!,
        isUser: true
    )
}
