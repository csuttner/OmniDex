//
//  ConversationListView.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/28/24.
//

import SwiftUI

struct ConversationListView: View {
    @State private var dataStore: SwiftDataStore?
    @State private var conversations = [Conversation]()
    @State private var path = [Conversation]()
    @State private var errorItem: ErrorItem?
    
    var body: some View {
        NavigationStack(path: $path) {
            List(conversations) { conversation in
                NavigationLink(value: conversation) {
                    HStack {
                        Text(conversation.updated.formatted(date: .abbreviated, time: .shortened))
                        Text(conversation.summary)
                    }
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
                ConversationView(dataStore: dataStore)
                    .environment(conversation)
            }
        }
        .task(id: path) {
            if dataStore == nil {
                dataStore = SwiftDataStore()
            }
            
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
            let stored: [StoredConversation] = try await dataStore?.fetchAll() ?? []
            
            conversations = stored.map(\.conversation).sorted { $0.updated > $1.updated }

        } catch {
            errorItem = ErrorItem(error: error)
        }
    }
}

#Preview {
    ConversationListView()
}
