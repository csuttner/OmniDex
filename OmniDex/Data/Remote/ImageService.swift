//
//  ImageService.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/17/24.
//

import Foundation
import OpenAISwift

protocol ImageService {
    func fetchImageGeneration(prompt: String) async throws -> URL
    func fetchImageEdit(image: Data, prompt: String, mask: Data?) async throws -> URL
    func fetchImageVariation(image: Data) async throws -> URL
}

extension OpenAISwift.ImageService: ImageService {
    func fetchImageGeneration(prompt: String) async throws -> URL {
        let payload = ImageGenerationPayload(prompt: prompt)
        
        let image = try await fetchImageGeneration(payload: payload)
        
        guard let url = image.data.first?.url else {
            throw URLError(.fileDoesNotExist)
        }
        
        return url
    }
    
    func fetchImageEdit(image: Data, prompt: String, mask: Data?) async throws -> URL {
        let payload = ImageEditPayload(image: image, prompt: prompt, mask: mask)
        
        let image = try await fetchImageEdit(payload: payload)
        
        guard let url = image.data.first?.url else {
            throw URLError(.fileDoesNotExist)
        }
        
        return url
    }
    
    func fetchImageVariation(image: Data) async throws -> URL {
        let payload = ImageVariationPayload(image: image)
        
        let image = try await fetchImageVariation(payload: payload)
        
        guard let url = image.data.first?.url else {
            throw URLError(.fileDoesNotExist)
        }
        
        return url
    }
}
