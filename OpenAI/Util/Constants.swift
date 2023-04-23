//
//  Constants.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

enum Constants {
    enum URLs {
        static let completions = URL(string: "https://api.openai.com/v1/chat/completions")!
    }
    
    enum Headers {
        static let bearerToken = "Bearer \(Secrets.apiKey)"
        static let authorization = "Authorization"
        static let contentType = "Content-Type"
        static let applicationJson = "application/json"
    }
}
