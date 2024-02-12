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

        guard let httpResponse = response as? HTTPURLResponse
        else {
            throw URLError(.badServerResponse)
        }

        if let apiError = APIError(data: data, httpResponse: httpResponse) {
            throw apiError
        }

        return try JSONDecoder.shared.decode(T.self, from: data)
    }
}
