//
//  ChatMessageView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct ChatMessageView: View {
    let viewModel: ChatMessageViewModel
    
    @State private var height: CGFloat = .zero
    
    var body: some View {
        HStack(alignment: .bottom) {
            if !viewModel.isUser {
                Image(systemName: viewModel.imageName)
            }
            
            HStack {
                if viewModel.isLoading {
                    EllipsesLoadingView()
                        
                } else {
                    Text(viewModel.content)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.white)
                }
            }
            .padding(8)
            .background(
                ChatMessageShape(isUser: viewModel.isUser)
                    .foregroundColor(viewModel.isUser ? .blue : .gray)
            )
            
            
            if viewModel.isUser {
                Image(systemName: viewModel.imageName)
            }
        }
        .frame(
            maxWidth: .infinity,
            alignment: viewModel.isUser ? .trailing : .leading
        )
    }

}


struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView(viewModel: Mocks.chatMessageViewModel)
            .padding()
        
        ChatMessageView(viewModel: Mocks.chatMessageViewModelLoading)
            .padding()
    }
}
