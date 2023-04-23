//
//  ChatService.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

class ChatService {
    private init() {}
    
    static let shared = ChatService()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func sendChat(newMessage: String, history: [ChatMessage]) async throws -> ChatResponse {
        var request = URLRequest(url: Constants.URLs.completions)
        var chatHistory = history
        chatHistory.append(ChatMessage(role: .user, content: newMessage))
        
        request.setValue(Constants.Headers.applicationJson, forHTTPHeaderField: Constants.Headers.contentType)
        request.setValue(Constants.Headers.bearerToken, forHTTPHeaderField: Constants.Headers.authorization)
        request.httpBody = try encoder.encode(ChatBody(messages: chatHistory))
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw APIError.invalidResponse }
        guard statusCode == 200 else { throw APIError.badStatusCode(statusCode) }
        
        return try decoder.decode(ChatResponse.self, from: data)
    }
}
