//
//  APIError.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public struct APIError: DetailedError {
    let statusCode: Int
    let message: String
    
    public var detailedErrorType: String {
        Constants.Error.apiError
    }
    
    public var detailedDescription: String {
        "\(statusCode) - \(message)"
    }

    init?(data: Data, httpResponse: HTTPURLResponse) {
        if 
            !(200...299).contains(httpResponse.statusCode),
            let errorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
            self.statusCode = httpResponse.statusCode
            self.message = errorResponse.error.message
        } else {
            return nil
        }
    }
}
