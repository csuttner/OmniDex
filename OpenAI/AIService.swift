//
//  AIService.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

class AIService {
    private init() {}
    
    static let shared = AIService()
    
    private let encoder = JSONEncoder()
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func sendChat(newMessage: String, history: [AIChatMessage]) async throws -> AIChatResponse {
        var request = URLRequest(url: Constants.URLs.completions)
        var chatHistory = history
        chatHistory.append(AIChatMessage(role: .user, content: newMessage))
        
        request.setValue(Constants.Headers.applicationJson, forHTTPHeaderField: Constants.Headers.contentType)
        request.setValue(Constants.Headers.bearerToken, forHTTPHeaderField: Constants.Headers.authorization)
        request.httpBody = try encoder.encode(AIChatBody(messages: chatHistory))
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw AINetworkError.invalidResponse }
        guard statusCode == 200 else { throw AINetworkError.badStatusCode(statusCode) }
        
        return try decoder.decode(AIChatResponse.self, from: data)
    }
}
