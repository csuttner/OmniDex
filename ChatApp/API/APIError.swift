//
//  APIError.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case badStatusCode(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Error - invalid response"
        case let .badStatusCode(code):
            return "Error - \(code) status code"
        }
    }
}
