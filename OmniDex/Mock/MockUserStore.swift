//
//  MockUserStore.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import Foundation
import UIKit

actor MockUserStore: UserStore {
    func save(user: User) async throws {
        
    }
    
    func fetchUser() async throws -> User {
        User(id: UUID().uuidString, image: UIImage(named: "Clay")?.pngData())
    }
}
