//
//  AIAPIError.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public struct AIAPIError: LocalizedError {
    public let statusCode: Int
    public let message: String
    
    public var errorDescription: String? {
        "\(statusCode) - \(message)"
    }
    
    init?(data: Data, httpResponse: HTTPURLResponse) {
        if 
            !(200...299).contains(httpResponse.statusCode),
            let errorResponse = try? JSONDecoder().decode(AIAPIErrorResponse.self, from: data) {
            self.statusCode = httpResponse.statusCode
            self.message = errorResponse.error.message
        } else {
            return nil
        }
    }
}
