//
//  ChatMessageView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct ChatMessageStyle {
    var cornerRadius: CGFloat = 12
    var minHeight: CGFloat = 24
    var lineWidth: CGFloat = 1
    var padding: CGFloat = 8
    let accentColor: Color
    
    init(isUser: Bool) {
        accentColor = isUser ? .blue : .gray
    }
}

struct ChatMessageView: View {
    let viewModel: ChatMessageViewModel
    
    var style: ChatMessageStyle {
        ChatMessageStyle(isUser: viewModel.isUser)
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            FlipGroup(if: viewModel.isUser) {
                ChatUserCircle(
                    imageName: viewModel.imageName,
                    style: style
                )

                ChatTextBubble(
                    isLoading: viewModel.isLoading,
                    content: viewModel.content,
                    isUser: viewModel.isUser
                )
            }
        }
        .frame(
            maxWidth: .infinity,
            alignment: viewModel.isUser ? .trailing : .leading
        )
        .padding([.leading, .trailing], style.padding * 2)
        .padding([.top, .bottom], style.padding)
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView(viewModel: Mock.chatMessageViewModel)
            .padding()
        
        ChatMessageView(viewModel: Mock.chatMessageViewModelLoading)
            .padding()
    }
}
