//
//  ConversationRootView.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/28/24.
//

import SwiftUI

struct ConversationRootConfig {
    var selection = Set<String>()
    var deleteSelection = Set<String>()
    var editMode = EditMode.inactive
    var path = [Conversation]()
    
    mutating func resetSelection() {
        selection.removeAll()
        deleteSelection.removeAll()
    }
}

struct ConversationRootView: View {
    let store: ConversationStore
    let service: ChatService

    @State private var conversations = [Conversation]()
    @State private var config = ConversationRootConfig()
    @State private var alertItem = AlertItem()
    
    var body: some View {
        NavigationStack(path: $config.path) {
            ConversationRootContentView(
                conversations: conversations,
                config: $config
            )
            .navigationTitle(Constants.Chat.conversations)
            .toolbar {
                if !conversations.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
                
                NewConversationToolbarItem(path: $config.path)
                
                if !config.selection.isEmpty {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete ^[\(config.selection.count) conversations](inflect: true)") {
                            config.deleteSelection = config.selection
                        }
                    }
                }
            }
            .environment(\.editMode, $config.editMode)
            .onChange(of: conversations) {
                if conversations.isEmpty {
                    config.editMode = .inactive
                }
            }
            .navigationDestination(for: Conversation.self) { conversation in
                ConversationView(service: service, store: store)
                    .environment(conversation)
            }
        }
        .task(id: config.path) {
            if config.path.isEmpty {
                await loadStoredConversations()
            }
        }
        .task(id: config.deleteSelection) {
            guard !config.deleteSelection.isEmpty else {
                return
            }
            
            let toBeDeleted = conversations.filter {
                config.deleteSelection.contains($0.id)
            }
            
            await delete(conversations: toBeDeleted)
            
            config.resetSelection()
            
            await loadStoredConversations()
        }
    }
    
    private func loadStoredConversations() async {
        do {
            conversations = try await store.fetchConversations()

        } catch {
            alertItem = AlertItem(error: error)
        }
    }
    
    private func delete(conversations: [Conversation]) async {
        do {
            try await store.delete(conversations: conversations)
            
        } catch {
            alertItem = AlertItem(error: error)
        }
    }
}

#Preview {
    ConversationRootView(
        store: MockConversationStore(),
        service: MockChatService()
    )
}
