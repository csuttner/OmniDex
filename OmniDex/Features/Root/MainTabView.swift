//
//  MainTabView.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/26/24.
//

import SwiftUI

struct MainTabView: View {
    let store: ConversationStore
    let service: ChatService
    
    var body: some View {
        TabView {
            ConversationRootView(store: store, service: service)
                .tabItem {
                    Label(Constants.Tabs.chat, systemImage: "ellipsis.message")
                }
            
            TranslateView()
                .tabItem {
                    Label(Constants.Tabs.translate, systemImage: "arrow.left.arrow.right")
                }
            
            ImagineView()
                .tabItem {
                    Label(Constants.Tabs.imagine, systemImage: "wand.and.stars")
                }
            
            SummarizeView()
                .tabItem {
                    Label(Constants.Tabs.summarize, systemImage: "sum")
                }
        }
        .tint(Color(Constants.Color.interactive))
    }
}
