//
//  DataStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation

protocol DataStore {
    func fetchConversations() async throws -> [Conversation]
    func delete(conversation: Conversation) async throws
    func delete(conversations: [Conversation]) async throws
    func save(conversation: Conversation) async throws
}
