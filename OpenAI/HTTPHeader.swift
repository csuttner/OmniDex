//
//  HTTPHeader.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

struct HTTPHeader {
    let field: String
    let value: String
    
    static let contentType = HTTPHeader(field: "Content-Type", value: "application/json")
    static let authorization = HTTPHeader(field: "Authorization", value: "Bearer \(Secrets.apiKey)")
}
