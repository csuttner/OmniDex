//
//  ClientError.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/11/24.
//

import Foundation

extension DecodingError: DetailedError {
    public var detailedErrorType: String {
        Constants.Error.decodingError
    }

    public var detailedDescription: String {
        switch self {
        case .typeMismatch(let type, let context):
            return "Type '\(type)' mismatch: \(context.formattedDescription)"
            
        case .valueNotFound(let value, let context):
            return "Value '\(value)' not found: \(context.formattedDescription)"
            
        case .keyNotFound(let codingKey, let context):
            return "Key '\(codingKey)' not found: \(context.formattedDescription)"
            
        case .dataCorrupted(let context):
            return context.debugDescription
            
        default:
            return "Unknown"
        }
    }
}

extension DecodingError.Context {
    var formattedDescription: String {
        "\(debugDescription)\n\ncodingPath: \(codingPath.map(\.stringValue).joined(separator: ", "))"
    }
}
