//
//  AIService.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public class AIService {
    private init() {}
    
    public static let shared = AIService()
    
    private let encoder = JSONEncoder()
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    public func submit(prompt: String, history: [AIChatMessage]) async throws -> AIReplyResponse {
        var request = URLRequest(url: Constants.URLs.completions)
        var chatHistory = history
        chatHistory.append(AIChatMessage(role: .user, content: prompt))
        
        request.httpMethod = "POST"
        request.setValue(Constants.Headers.applicationJson, forHTTPHeaderField: Constants.Headers.contentType)
        request.setValue(Constants.Headers.bearerToken, forHTTPHeaderField: Constants.Headers.authorization)
        request.httpBody = try encoder.encode(AIPromptBody(messages: chatHistory))
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw AINetworkError.invalidResponse }
        guard statusCode == 200 else { throw AINetworkError.badStatusCode(statusCode) }
        
        return try decoder.decode(AIReplyResponse.self, from: data)
    }
}
