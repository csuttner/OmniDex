//
//  MockConversationStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation

actor MockConversationStore: ConversationStore {
    func save(conversation: Conversation) async throws {}
    
    func fetchConversations() async throws -> [Conversation] {
        [Mock.conversation, Mock.conversation, Mock.conversation]
    }
    
    func delete(conversation: Conversation) async throws {}
    
    func delete(conversations: [Conversation]) async throws {}
}