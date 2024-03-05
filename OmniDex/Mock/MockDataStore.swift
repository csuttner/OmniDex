//
//  MockDataStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation

actor MockDataStore: DataStore {
    func save(conversation: Conversation) async throws {}
    
    func fetchConversations() async throws -> [Conversation] {
        [Mock.conversation]
    }
    
    func delete(conversation: Conversation) async throws {}
    
    func delete(conversations: [Conversation]) async throws {}
}
