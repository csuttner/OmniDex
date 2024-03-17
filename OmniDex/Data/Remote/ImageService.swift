//
//  ImageService.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/17/24.
//

import Foundation
import OpenAISwift

protocol ImageService {
    func fetchImageGeneration(prompt: String) async throws -> Data
    func fetchImageEdit(image: Data, prompt: String, mask: Data?) async throws -> Data
    func fetchImageVariation(image: Data) async throws -> Data
}

extension OpenAISwift.ImageService: ImageService {
    func fetchImageGeneration(prompt: String) async throws -> Data {
        let payload = ImageGenerationPayload(prompt: prompt)
        
        let response = try await fetchImageGeneration(payload: payload)
        
        return try await fetchImageData(from: response)
    }
    
    func fetchImageEdit(image: Data, prompt: String, mask: Data?) async throws -> Data {
        let payload = ImageEditPayload(image: image, prompt: prompt, mask: mask)
        
        let response = try await fetchImageEdit(payload: payload)
        
        return try await fetchImageData(from: response)
    }
    
    func fetchImageVariation(image: Data) async throws -> Data {
        let payload = ImageVariationPayload(image: image)
        
        let response = try await fetchImageVariation(payload: payload)
        
        return try await fetchImageData(from: response)
    }
    
    private func fetchImageData(from response: ImageResponse) async throws -> Data {
        guard let url = response.data.first?.url else {
            throw URLError(.fileDoesNotExist)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return data
    }
}
