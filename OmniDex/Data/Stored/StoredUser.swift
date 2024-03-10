//
//  StoredUser.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import Foundation
import SwiftData

@Model class StoredUser {
    @Attribute(.unique) let id: String
    var name: String
    @Attribute(.externalStorage) var image: Data?
    
    var user: User {
        User(id: id, name: name, image: image)
    }
    
    init(id: String, name: String, image: Data? = nil) {
        self.id = id
        self.name = name
        self.image = image
    }
}
