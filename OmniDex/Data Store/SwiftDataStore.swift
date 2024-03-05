//
//  SwiftDataStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation
import SwiftData

actor SwiftDataStore {
    @MainActor init?() {
        if let container = try? ModelContainer(
            for: StoredConversation.self,
            configurations: ModelConfiguration()
        ) {
            self.context = container.mainContext
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

extension SwiftDataStore: DataStore {
    func save(conversation: Conversation) async throws {
        let conversationId = conversation.id
        
        let descriptor = FetchDescriptor<StoredConversation>(
            predicate: #Predicate { $0.id == conversationId }
        )
        
        if let existing = try await fetch(descriptor).first {
            existing.update(with: conversation)

            try context.save()
            
            print("updated conversation:", conversation.summary)

        } else {
            try await store(item: StoredConversation(conversation: conversation))
            
            print("stored conversation:", conversation.summary)
        }
    }
    
    func fetchConversations() async throws -> [Conversation] {
        let descriptor = FetchDescriptor<StoredConversation>(
            sortBy: [.init(\.updated)]
        )
        
        return try await fetch(descriptor)
            .map { stored in
                let conversation = stored.conversation
                
                conversation.messages.sort { $0.date < $1.date }
                
                return conversation
            }
    }
    
    func delete(conversation: Conversation) async throws {
        try await delete(item: StoredConversation(conversation: conversation))
    }
    
    func delete(conversations: [Conversation]) async throws {
        try await delete(items: conversations.map(StoredConversation.init))
    }
}
