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
    
    public func fetchChatCompletion(
        prompt: String,
        history: [AIChatMessage]
    ) async throws -> AIChatCompletionResponse {
        try await fetchDecodable(.chatCompletion(prompt, history))
    }
    
    private func fetchDecodable<T: Decodable>(_ router: AIServiceRouter) async throws -> T {
        let request = try router.asURLRequest()

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        if let apiError = AIAPIError(data: data, httpResponse: httpResponse) {
            throw apiError
        }

        return try JSONDecoder.shared.decode(T.self, from: data)
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
        
        request.httpMethod = httpMethod.rawValue
        request.httpHeaders = httpHeaders
        
        if let body {
            request.httpBody = try JSONEncoder.shared.encode(body)
        }
        
        return request
    }
    
    var body: Encodable? {
        switch self {
        case .chatCompletion(let prompt, var history):
            history.append(AIChatMessage(role: .user, content: prompt))
            return AIChatCompletionRequest(messages: history)
        }
    }
    
    var httpHeaders: [HTTPHeader] {
        [.contentType, .authorization]
    }
    
    var path: String {
        switch self {
        case .chatCompletion:
            return "/chat/completions"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .chatCompletion:
            return .post
        }
    }
}
