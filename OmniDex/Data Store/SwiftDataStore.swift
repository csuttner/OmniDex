//
//  SwiftDataStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation
import SwiftData

actor SwiftDataStore {

    init?() {
        if let container = try? ModelContainer(
            for: StoredConversation.self,
            configurations: ModelConfiguration()
        ) {
            self.context = ModelContext(container)
        } else {
            return nil
        }
    }
    
    
    private let context: ModelContext

    func store<T: PersistentModel>(item: T) async throws {
        try context.transaction {
            context.insert(item)
            
            try context.save()
        }
        
        print("Saved item:", item.persistentModelID)
    }
    
    func store<T: PersistentModel>(items: [T]) async throws {
        try context.transaction {
            for item in items {
                context.insert(item)
            }
            
            try context.save()
        }
    }
    
    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) async throws -> [T] {
        try context.fetch(descriptor)
    }
    
    func delete<T: PersistentModel>(item: T) async throws {
        try context.transaction {
            context.delete(item)
            
            try context.save()
        }   
    }
    
    func delete<T: PersistentModel>(items: [T]) async throws {
        try context.transaction {
            for item in items {
                context.delete(item)
            }
            
            try context.save()
        }
    }
}

extension SwiftDataStore: ConversationStore {
    func save(conversation: Conversation) async throws {
        let conversationId = conversation.id
        
        let descriptor = FetchDescriptor<StoredConversation>(
            predicate: #Predicate { $0.id == conversationId }
        )
        
        if let existing = try await fetch(descriptor).first {
            try await update(stored: existing, with: conversation)
            
            print("updated conversation:", conversation.summary ?? Constants.Chat.noSummary)

        } else {
            try await store(item: makeStored(conversation: conversation))
            
            print("stored conversation:", conversation.summary ?? Constants.Chat.noSummary)
        }
    }
    
    func fetchConversations() async throws -> [Conversation] {
        let descriptor = FetchDescriptor<StoredConversation>(
            sortBy: [.init(\.updated, order: .reverse)]
        )
        
        return try await fetch(descriptor).map(\.conversation)
    }
    
    func delete(conversation: Conversation) async throws {
        try await delete(item: makeStored(conversation: conversation))
    }
    
    func delete(conversations: [Conversation]) async throws {
        try await delete(items: conversations.map(makeStored))
    }
    
    func makeStored(conversation: Conversation) -> StoredConversation {
        let stored = StoredConversation(
            id: conversation.id,
            updated: conversation.updated,
            summary: conversation.summary
        )
        
        stored.messages = conversation.messages.map(StoredMessage.init)
        
        return stored
    }
    
    func update(stored: StoredConversation, with conversation: Conversation) async throws {
        let messageIds = stored.messages.map(\.id)

        let newMessages = conversation.messages
            .filter { !messageIds.contains($0.id) }
            .map(StoredMessage.init)

        stored.messages.append(contentsOf: newMessages)
        stored.updated = conversation.updated
        stored.summary = conversation.summary
        
        try context.save()
    }
}
