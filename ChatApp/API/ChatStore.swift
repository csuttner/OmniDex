//
//  ChatStore.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

class ChatStore {
    private init() {}
    
    static let shared = ChatStore()
    
    var history = [ChatMessage]()
}
