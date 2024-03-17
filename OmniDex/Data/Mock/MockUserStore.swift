//
//  MockUserStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import Foundation
import UIKit

actor MockUserStore: UserStore {
    func fetchUser() async throws -> User {
        Mock.user
    }
    
    func save(user: User) async throws {}
}
