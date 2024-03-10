//
//  ChatMessageStyle.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import SwiftUI

struct MessageStyle {
    var cornerRadius: CGFloat = 18
    var minHeight: CGFloat = 24
    var lineWidth: CGFloat = 1
    var padding: CGFloat = 12
    let accentColor: Color
    let clipShape: UnevenRoundedRectangle

    init(isUser: Bool) {
        accentColor = isUser
            ? Color(Constants.Color.interactive)
            : .gray
        
        clipShape = .init(cornerRadii: .init(
                topLeading: cornerRadius,
                bottomLeading: isUser ? cornerRadius : 0.0,
                bottomTrailing: isUser ? 0.0 : cornerRadius,
                topTrailing: cornerRadius
            ))
    }
}
