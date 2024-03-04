//
//  MessageChunk.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/25/24.
//

import Foundation

struct MessageChunk {
    let id: String
    let date: Date
    let text: String
    
    var message: Message {
        Message(
            id: id,
            date: date,
            isUser: false,
            text: text
        )
    }
}
