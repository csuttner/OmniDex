//
//  StoredUser.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import Foundation
import SwiftData

@Model class StoredUser {
    @Attribute(.unique) let localID: String
    var name: String
    @Attribute(.externalStorage) var image: Data?
    
    var user: User {
        User(id: localID, name: name, image: image)
    }
    
    init(localID: String, name: String, image: Data? = nil) {
        self.localID = localID
        self.name = name
        self.image = image
    }
}
