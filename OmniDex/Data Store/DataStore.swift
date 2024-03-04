//
//  DataStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import Foundation

protocol DataStore {
    associatedtype StoreModel
    
    func store(item: StoreModel) async throws
    func store(items: [StoreModel]) async throws
    func fetchAll() async throws -> [StoreModel]
    func delete(item: StoreModel) async throws
    func delete(items: [StoreModel]) async throws
}
