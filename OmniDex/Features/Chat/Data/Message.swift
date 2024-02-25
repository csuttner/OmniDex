//
//  ChatMessage.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

class Message: ObservableObject, Identifiable {
    let id: String
    let date: Date
    let isUser: Bool
    @Published var text = ""
    var image: String?
    var isLoading: Bool
    
    var imageName: String {
        isUser ? "Clay" : "Robot"
    }
    
    init(
        id: String = UUID().uuidString,
        date: Date = Date(),
        isUser: Bool = true,
        text: String = "",
        image: String? = nil,
        isLoading: Bool = false
    ) {
        self.id = id
        self.date = date
        self.isUser = isUser
        self.text = text
        self.image = image
        self.isLoading = isLoading
    }
}

extension Message: Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
}
