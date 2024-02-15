//
//  Fetchable.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

protocol Fetchable {}

extension Fetchable {
    func fetchDecodable<T: Decodable>(_ router: ServiceRouter) async throws -> T {
        let request = try router.asURLRequest()

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        if let apiError = APIError(data: data, httpResponse: httpResponse) {
            throw apiError
        }

        return try JSONDecoder.shared.decode(T.self, from: data)
    }
    
    func fetchDecodableStream(_ router: ServiceRouter) async throws -> AsyncThrowingStream<ChatCompletionChunk, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    let request = try router.asURLRequest()

                    let (data, response) = try await URLSession.shared.data(for: request)
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw URLError(.badServerResponse)
                    }

                    if let apiError = APIError(data: data, httpResponse: httpResponse) {
                        throw apiError
                    }

                    let rawChunks = data.split(separator: UInt8(ascii: "\n"))
                    
                    for rawChunk in rawChunks {
                        guard
                            let chunkString = String(bytes: rawChunk, encoding: .utf8),
                            chunkString.hasPrefix("data:"),
                            let payload = String(chunkString.dropFirst(5)).data(using: .utf8) else {
                            continue
                        }
                        
                        if let chunk = try? JSONDecoder.shared.decode(ChatCompletionChunk.self, from: payload) {
                            continuation.yield(chunk)
                        }
                    }

                    continuation.finish()

                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
