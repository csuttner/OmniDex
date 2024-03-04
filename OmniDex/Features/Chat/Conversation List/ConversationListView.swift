//
//  ConversationListView.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/28/24.
//

import SwiftUI

struct ConversationListView: View {
    let dataStore: DataStore
    let chatService: ChatService

    @State private var conversations = [Conversation]()
    @State private var path = [Conversation]()
    @State private var errorItem: ErrorItem?
    
    var body: some View {
        NavigationStack(path: $path) {
            List(conversations) { conversation in
                NavigationLink(value: conversation) {
                    ConversationListRow(conversation: conversation)
                }
            }
            .navigationTitle(Constants.Chat.conversations)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        path.append(Conversation())
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text(Constants.Common.new)
                        }
                        .fontWeight(.semibold)
                    }
                }
            }
            .navigationDestination(for: Conversation.self) { conversation in
                ConversationView(chatService: chatService, dataStore: dataStore)
                    .environment(conversation)
            }
        }
        .task(id: path) {
            if path.isEmpty {
                await loadStoredConversations()
            }
        }
        .alert(item: $errorItem) { errorItem in
            Alert(
                title: Text(errorItem.title),
                message: Text(errorItem.message),
                dismissButton: .default(Text("OK")) {
                    self.errorItem = nil
                }
            )
        }
    }
    
    private func loadStoredConversations() async {
        do {
            conversations = try await dataStore.fetchConversations()

        } catch {
            errorItem = ErrorItem(error: error)
        }
    }
}

#Preview {
    ConversationListView(
        dataStore: MockDataStore(),
        chatService: MockChatService()
    )
}
