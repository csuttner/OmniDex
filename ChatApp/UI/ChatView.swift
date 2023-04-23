//
//  ChatView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        VStack {
            ForEach($viewModel.chatMessages) { chatMessage in
                MessageView(viewModel: MessageViewModel(chatMessage: chatMessage.wrappedValue))
            }
        }
        .padding()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: ChatViewModel.mock)
    }
}
