//
//  StoreProvider.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import Foundation
import Observation

@Observable class StoreProvider {
    let conversationStore: ConversationStore
    let userStore: UserStore
    
    init(conversationStore: ConversationStore, userStore: UserStore) {
        self.conversationStore = conversationStore
        self.userStore = userStore
    }
}
