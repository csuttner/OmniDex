//
//  ErrorItem.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation
import OpenAISwift
import SwiftUI

struct AlertItem {
    var isPresented: Bool
    var title: String
    var message: String?
    
    init(
        isPresented: Bool = false,
        title: String = "",
        message: String? = nil
    ) {
        self.isPresented = isPresented
        self.title = title
        self.message = message
    }

    init(error: Error) {
        isPresented = true
        
        if let detailedError = error as? DetailedError {
            title = detailedError.detailedErrorType
            message = detailedError.detailedDescription

        } else {
            title = Constants.Error.error
            message = error.localizedDescription
        }
    }

    mutating func reset() {
        isPresented = false
        title = ""
        message = nil
    }
}
