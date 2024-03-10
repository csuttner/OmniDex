//
//  StoreError.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import Foundation
import OpenAISwift

enum StoreError: DetailedError {
    case noUserFound
    
    var detailedErrorType: String {
        Constants.Error.storeError
    }
    
    var detailedDescription: String {
        Constants.Error.noUserFound
    }
}
