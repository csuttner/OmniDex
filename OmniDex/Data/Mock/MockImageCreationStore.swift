//
//  MockImageCreationStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/17/24.
//

import Foundation

actor MockImageCreationStore: ImageCreationStore {
    func fetchCreations() async throws -> [ImageCreation] {
        [Mock.imageCreation, Mock.imageCreation, Mock.imageCreation]
    }
    
    func delete(creations: [ImageCreation]) async throws {}
    
    func save(creation: ImageCreation) async throws {}
}
