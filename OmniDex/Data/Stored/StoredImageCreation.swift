//
//  StoredImageCreation.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/17/24.
//

import Foundation
import SwiftData

@Model class StoredImageCreation {
    @Attribute(.unique) var localID: String
    var date: Date
    @Attribute(.externalStorage) var image: Data
    var creationType: String
    
    var imageCreation: ImageCreation {
        ImageCreation(
            id: localID, 
            created: date,
            image: image,
            creationType: ImageCreationType(rawValue: creationType) ?? .generation
        )
    }
    
    init(
        localID: String,
        date: Date,
        image: Data,
        creationType: String
    ) {
        self.localID = localID
        self.date = date
        self.image = image
        self.creationType = creationType
    }
}
