//
//  UserPictureCircle.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct SmallImageCircle: View {
    let userImage: UIImage?
    let style: MessageStyle
    
    var body: some View {
        Group {
            if style.isUser, let userImage {
                Image(uiImage: userImage)
                    .resizable()

            } else if style.isUser {
                Image(systemName: "person.circle")
                    .resizable()

            } else {
                Image("Robot")
                    .resizable()
            }
        }
        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
        .foregroundStyle(style.accentColor)
        .frame(width: style.minHeight, height: style.minHeight)
        .clipped()
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(style.accentColor, lineWidth: style.lineWidth)
        )
    }
}

#Preview {
    SmallImageCircle(
        userImage: UIImage(named: "Clay")!,
        style: MessageStyle(isUser: true)
    )
}

#Preview {
    SmallImageCircle(
        userImage: UIImage(named: "Clay")!,
        style: MessageStyle(isUser: false)
    )
}

#Preview {
    SmallImageCircle(
        userImage: nil,
        style: MessageStyle(isUser: true)
    )
}
