//
//  MockImageService.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/17/24.
//

import Foundation
import UIKit

class MockImageService: ImageService {
    func fetchImageGeneration(prompt: String) async throws -> Data {
        UIImage(named: "Lambo")!.pngData()!
    }
    
    func fetchImageEdit(image: Data, prompt: String, mask: Data?) async throws -> Data {
        UIImage(named: "Lambo")!.pngData()!
    }
    
    func fetchImageVariation(image: Data) async throws -> Data {
        UIImage(named: "Lambo")!.pngData()!
    }
}
