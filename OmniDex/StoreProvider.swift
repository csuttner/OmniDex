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
    let imageCreationStore: ImageCreationStore
    let userStore: UserStore
    
    init(
        conversationStore: ConversationStore,
        imageCreationStore: ImageCreationStore,
        userStore: UserStore
    ) {
        self.conversationStore = conversationStore
        self.imageCreationStore = imageCreationStore
        self.userStore = userStore
    }
}
