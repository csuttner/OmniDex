//
//  ErrorItem.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

struct ErrorItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String

    init(error: Error) {
        if let detailedError = error as? DetailedError {
            title = detailedError.detailedErrorType
            message = detailedError.detailedDescription
        } else {
            title = Constants.Common.error
            message = error.localizedDescription
        }
    }
}
