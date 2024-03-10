//
//  UserPictureCircle.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct UserPictureCircle: View {
    let imageName: String
    let style: MessageStyle

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
            .task {
                await fetchUser()
            }
    }
    
    private func fetchUser() async {
        
    }
}

#Preview {
    UserPictureCircle(imageName: "Clay", style: MessageStyle(isUser: true))
}
