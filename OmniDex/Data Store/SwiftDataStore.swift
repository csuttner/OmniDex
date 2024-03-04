//
//  SwiftDataStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation
import SwiftData

actor SwiftDataStore {
    typealias StoreModel = PersistentModel
    
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
    
    func fetchAll<T: PersistentModel>() async throws -> [T] {
        try context.fetch(FetchDescriptor<T>())
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

