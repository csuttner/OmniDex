//
//  ErrorItem.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

struct ErrorItem: Identifiable {
    let id = UUID()
    let title = "Error"
    let localizedDescription: String
    
    init(error: Error) {
        localizedDescription = error.localizedDescription
    }
}
