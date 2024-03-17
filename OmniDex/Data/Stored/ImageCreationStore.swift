//
//  ImageCreationStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/17/24.
//

import Foundation

protocol ImageCreationStore {
    func fetchCreations() async throws -> [ImageCreation]
    func delete(creations: [ImageCreation]) async throws
    func save(creation: ImageCreation) async throws
}
