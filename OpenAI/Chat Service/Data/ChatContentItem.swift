//
//  ChatContent.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/11/24.
//

import Foundation

enum ChatContentType: String, Codable {
    case text
    case image = "image_url"
}

struct ChatContentItem: Codable {
    let type: ChatContentType
    var text: String?
    var imageUrl: ChatImageUrl?
}

struct ChatImageUrl: Codable {
    let url: String
}
