//
//  ChatMessageView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct ChatMessageView: View {
    let viewModel: ChatMessageViewModel
    
    var style: ChatMessageStyle {
        ChatMessageStyle(isUser: viewModel.isUser)
    }
    
    var body: some View {
        VStack(alignment: viewModel.isUser ? .trailing : .leading, spacing: style.padding) {
            if
                let imageString = viewModel.image,
                let image = UIImage.fromBase64(imageString) {
                ChatImageBubble(
                    image: image,
                    isUser: viewModel.isUser
                )
                .padding(viewModel.isUser ? .trailing : .leading, style.minHeight + style.padding)
            }
            
            HStack(alignment: .bottom, spacing: style.padding) {
                FlipGroup(if: viewModel.isUser) {
                    ChatUserCircle(
                        imageName: viewModel.senderImageName,
                        style: style
                    )
                    
                    ChatTextBubble(
                        isLoading: viewModel.isLoading,
                        content: viewModel.text,
                        isUser: viewModel.isUser
                    )
                }
            }
            .frame(
                maxWidth: .infinity,
                alignment: viewModel.isUser ? .trailing : .leading
            )
        }
        .padding([.leading, .trailing], style.padding * 2)
        .padding([.top, .bottom], style.padding)
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView(
            viewModel: Mock.chatMessageViewModelWithImage
        )
        .padding()
    }
}
