//
//  MainTabView.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/26/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ChatView()
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
