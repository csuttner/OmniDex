//
//  MockImageService.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/17/24.
//

import Foundation

class MockImageService: ImageService {
    func fetchImageGeneration(prompt: String) async throws -> URL {
        URL(string: "https://picsum.photos/512")!
    }
    
    func fetchImageEdit(image: Data, prompt: String, mask: Data?) async throws -> URL {
        URL(string: "https://picsum.photos/512")!
    }
    
    func fetchImageVariation(image: Data) async throws -> URL {
        URL(string: "https://picsum.photos/512")!
    }
}
