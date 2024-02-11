//
//  ChatMessageStyle.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import SwiftUI

struct ChatMessageStyle {
    var cornerRadius: CGFloat = 12
    var minHeight: CGFloat = 24
    var lineWidth: CGFloat = 1
    var padding: CGFloat = 8
    let accentColor: Color
    
    init(isUser: Bool) {
        accentColor = isUser
            ? Color(Constants.Color.interactive)
            : .gray
    }
}
