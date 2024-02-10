//
//  ErrorItem.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import OpenAI
import Foundation

struct ErrorItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    
    init(error: Error) {
        if error is APIError {
            title = Constants.Error.apiError
        } else {
            title = Constants.Error.error
        }

        message = error.localizedDescription
    }
}
