//
//  MessageListView.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct MessageListView: View {
    @Environment(StoreProvider.self) private var storeProvider
    @Environment(Conversation.self) private var conversation
    
    @State private var lastMessage: Message?
    @State private var userImage: UIImage?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(conversation.messages) { message in
                    MessageView(
                        userImage: userImage,
                        message: message
                    )
                    .padding([.top, .leading, .trailing], 12)
                }
            }
            .padding(.bottom, 60)
            .scrollTargetLayout()
        }
        .defaultScrollAnchor(.bottom)
        .scrollPosition(id: $lastMessage, anchor: .bottom)
        .animation(.easeIn, value: conversation.messages)
        .onChange(of: conversation.messages) {
            lastMessage = conversation.messages.last
        }
        .task {
            if 
                let user = try? await storeProvider.userStore.fetchUser(),
                let imageData = user.image,
                let uiImage = UIImage(data: imageData) {
                userImage = uiImage
            }
        }
    }
}

#Preview {
    MessageListView()
        .environment(Mock.conversation)
}
