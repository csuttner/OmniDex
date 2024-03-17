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
    var editProfilePresented = false
    
    mutating func resetSelection() {
        selection.removeAll()
        deleteSelection.removeAll()
    }
}

struct ConversationRootView: View {
    @Environment(StoreProvider.self) private var storeProvider
    
    @Binding var tab: Tab
    
    @State private var conversations = [Conversation]()
    @State private var config = ConversationRootConfig()
    @State private var alertItem = AlertItem()
    
    var body: some View {
        NavigationStack(path: $config.path) {
            VStack {
                ConversationRootContentView(
                    conversations: conversations,
                    config: $config
                )
                
                TabBar(tab: $tab)
            }
            .toolbar {
                ConversationRootEditToolbarItem(config: $config)
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "square.and.pencil") {
                        config.path.append(Conversation())
                    }
                }
                
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
            .navigationTitle(Constants.Chat.conversations)
            .navigationDestination(for: Conversation.self) { conversation in
                ConversationView()
                    .environment(conversation)
            }
            .fullScreenCover(isPresented: $config.editProfilePresented) {
                EditProfileView()
            }
            .alert(item: $alertItem)
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
    }
    
    private func loadStoredConversations() async {
        do {
            conversations = try await storeProvider
                .conversationStore.fetchConversations()

        } catch {
            alertItem = AlertItem(error: error)
        }
    }
    
    private func delete(conversations: [Conversation]) async {
        do {
            try await storeProvider.conversationStore
                .delete(conversations: conversations)
            
        } catch {
            alertItem = AlertItem(error: error)
        }
    }
}

#Preview {
    ConversationRootView(tab: .constant(.chat))
        .environment(Mock.storeProvider)
}
