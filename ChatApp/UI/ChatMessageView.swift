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
                    .resizable()
                    .frame(width: 24, height: 24)
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
            .frame(minHeight: 24)
            .padding(8)
            .background(
                MaskedCornerShape(cornerRadius: 8, isUser: viewModel.isUser)
                    .foregroundColor(viewModel.isUser ? .blue : .gray)
            )
            
            if viewModel.isUser {
                Image(systemName: viewModel.imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .frame(
            maxWidth: .infinity,
            alignment: viewModel.isUser ? .trailing : .leading
        )
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 8)
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
