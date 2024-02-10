//
//  AIAPIErrorResponse.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

struct AIAPIErrorResponse: Decodable {
    let error: AIErrorMessage
}

struct AIErrorMessage: Decodable {
    let message: String
}
