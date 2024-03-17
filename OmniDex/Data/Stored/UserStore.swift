//
//  UserStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import Foundation

protocol UserStore {
    func fetchUser() async throws -> User
    func save(user: User) async throws
}

