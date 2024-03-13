//
//  RootView.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/26/24.
//

import SwiftUI

struct RootView: View {
    @State private var tab: Tab = .chat
    
    var body: some View {
        switch tab {
        case .chat:
            ConversationRootView(tab: $tab)
            
        case .translate:
            TranslateView(tab: $tab)
            
        case .imagine:
            ImagineView(tab: $tab)
            
        case .summarize:
            SummarizeView(tab: $tab)
        }
    }
}

