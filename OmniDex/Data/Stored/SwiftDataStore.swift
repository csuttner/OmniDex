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
            for: StoredConversation.self, StoredUser.self, StoredImageCreation.self,
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

// MARK: Conversation Store

extension SwiftDataStore: ConversationStore {
    func fetchConversations() async throws -> [Conversation] {
        let descriptor = FetchDescriptor<StoredConversation>(
            sortBy: [.init(\.date, order: .reverse)]
        )
        
        return try await fetch(descriptor).map(\.conversation)
    }
    
    func delete(conversations: [Conversation]) async throws {
        let existing = try await fetch(FetchDescriptor<StoredConversation>())

        let ids = conversations.map(\.id)
        
        try await delete(items: existing.filter { ids.contains($0.localID) })
    }
    
    func save(conversation: Conversation) async throws {
        let conversationId = conversation.id
        
        let descriptor = FetchDescriptor<StoredConversation>(
            predicate: #Predicate { $0.localID == conversationId }
        )
        
        if let existing = try await fetch(descriptor).first {
            try await update(stored: existing, with: conversation)
            
            print("updated conversation:", conversation.summary ?? Constants.Chat.noSummary)

        } else {
            try await store(item: makeStored(conversation: conversation))
            
            print("stored conversation:", conversation.summary ?? Constants.Chat.noSummary)
        }
    }
    
    private func makeStored(conversation: Conversation) -> StoredConversation {
        let stored = StoredConversation(
            localID: conversation.id,
            date: conversation.updated,
            summary: conversation.summary
        )
        
        stored.messages = conversation.messages.map(StoredMessage.init)
        
        return stored
    }
    
    private func update(stored: StoredConversation, with conversation: Conversation) async throws {
        let messageIds = stored.messages.map(\.localID)

        let newMessages = conversation.messages
            .filter { !messageIds.contains($0.id) }
            .map(StoredMessage.init)

        stored.messages.append(contentsOf: newMessages)
        stored.date = conversation.updated
        stored.summary = conversation.summary
        
        try context.save()
    }
}

// MARK: User Store

extension SwiftDataStore: UserStore {
    func fetchUser() async throws -> User {
        let descriptor = FetchDescriptor<StoredUser>()

        if let existing = try await fetch(descriptor).first {
            return existing.user

        } else {
            throw StoreError.noUserFound
        }
    }
    
    func save(user: User) async throws {
        let descriptor = FetchDescriptor<StoredUser>()
        
        if let existing = try await fetch(descriptor).first {
            existing.image = user.image
            
            try context.save()
            
            print("updated user:", existing.id)
            
        } else {
            try await store(item: makeStored(user: user))
            
            print("stored user:", user.id)
        }
    }
    
    
    private func makeStored(user: User) -> StoredUser {
        StoredUser(
            localID: user.id,
            name: user.name,
            image: user.image
        )
    }
}

// MARK: Image Creation Store

extension SwiftDataStore: ImageCreationStore {
    func fetchCreations() async throws -> [ImageCreation] {
        let descriptor = FetchDescriptor<StoredImageCreation>(
            sortBy: [.init(\.date, order: .reverse)]
        )
        
        return try await fetch(descriptor).map(\.imageCreation)
    }
    
    func delete(creations: [ImageCreation]) async throws {
        let existing = try await fetch(FetchDescriptor<StoredImageCreation>())

        let ids = creations.map(\.id)
        
        try await delete(items: existing.filter { ids.contains($0.localID) })
    }
    
    func save(creation: ImageCreation) async throws {
        let creationID = creation.id
        
        let descriptor = FetchDescriptor<StoredImageCreation>(
            predicate: #Predicate { $0.localID == creationID }
        )
        
        if let stored = makeStored(creation: creation) {
            try await store(item: stored)
            
            print("stored creation:")
        }
    }

    private func makeStored(creation: ImageCreation) -> StoredImageCreation? {
        guard let image = creation.image else {
            return nil
        }
        
        return StoredImageCreation(
            localID: creation.id,
            date: creation.created,
            image: image,
            creationType: creation.creationType.rawValue
        )
    }
}
