//
//  MockConversationStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation

actor MockConversationStore: ConversationStore {
    func fetchConversations() async throws -> [Conversation] {
        [Mock.conversation, Mock.conversation, Mock.conversation]
    }
    
    func delete(conversations: [Conversation]) async throws {}
    
    func save(conversation: Conversation) async throws {}
}
