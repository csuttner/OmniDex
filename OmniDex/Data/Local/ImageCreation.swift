//
//  ImageCreation.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/17/24.
//

import Foundation
import Observation

@Observable class ImageCreation: Identifiable {
    let id: String
    var created: Date
    var image: Data?
    var creationType: ImageCreationType
    
    init(
        id: String = UUID().uuidString,
        created: Date = Date(),
        image: Data? = nil,
        creationType: ImageCreationType = .generation
    ) {
        self.id = id
        self.created = created
        self.image = image
        self.creationType = creationType
    }
}

extension ImageCreation: Equatable {
    static func == (lhs: ImageCreation, rhs: ImageCreation) -> Bool {
        lhs.id == rhs.id
    }
}

extension ImageCreation: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum ImageCreationType: String, CaseIterable, Identifiable {
    case generation, edit, variation
    
    var id: String {
        rawValue
    }
}
