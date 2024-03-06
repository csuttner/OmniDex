//
//  ErrorItem.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation
import OpenAISwift
import SwiftUI

struct ErrorItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String

    init(error: Error) {
        if let detailedError = error as? DetailedError {
            title = detailedError.detailedErrorType
            message = detailedError.detailedDescription
        } else {
            title = Constants.Error.error
            message = error.localizedDescription
        }
    }
}

extension Binding where Value == ErrorItem? {
    var isSome: Binding<Bool> {
        Binding<Bool>(
            get: { wrappedValue != nil },
            set: { if !$0 { wrappedValue = nil } }
        )
    }
}
