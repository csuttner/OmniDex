//
//  User.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import Foundation
import Observation

@Observable class User {
    let id: String
    var name: String
    var image: Data?
    
    init(
        id: String = UUID().uuidString,
        name: String = "",
        image: Data? = nil
    ) {
        self.id = id
        self.name = name
        self.image = image
    }
}
