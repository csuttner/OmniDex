//
//  ServiceProvider.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/3/24.
//

import OpenAISwift

enum ServiceProvider {
    static let openAiChatService: ChatService = {
        let service = OpenAISwift.ChatService()
        OpenAISwift.Auth.apiKey = Secrets.apiKey
        return service
    }()
}
