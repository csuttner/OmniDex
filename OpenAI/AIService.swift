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
    
    public func fetchChatCompletion(
        prompt: String,
        history: [AIChatMessage]
    ) async throws -> AIChatCompletionResponse {
        try await fetchDecodable(.chatCompletion(prompt, history))
    }
    
    private func fetchDecodable<T: Decodable>(_ router: AIServiceRouter) async throws -> T {
        let request = try router.asURLRequest()
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response is HTTPURLResponse) else { throw URLError(.badServerResponse) }
        
        return try decoder.decode(T.self, from: data)
    }
}

enum AIServiceRouter {
    case chatCompletion(String, [AIChatMessage])
    
    private static let baseURL = "https://api.openai.com/v1"
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: Self.baseURL + path) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.field) }
        
        if let body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        return request
    }
    
    var body: Encodable? {
        switch self {
        case var .chatCompletion(prompt, history):
            history.append(AIChatMessage(role: .user, content: prompt))
            return AIChatCompletionRequest(messages: history)
        }
    }
    
    var headers: [HTTPHeader] {
        [.contentType, .authorization]
    }
    
    var path: String {
        switch self {
        case .chatCompletion:
            return "/chat/completions"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .chatCompletion:
            return .post
        }
    }
}
