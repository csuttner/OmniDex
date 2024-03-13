//
//  TabItem.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/12/24.
//

import SwiftUI

struct TabItem: View {
    let tab: Tab
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        Button {
            selectedTab = tab
        } label: {
            VStack {
                Image(systemName: tab.systemImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding(.top, 12)
                Text(tab.title)
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity)
        }
        .tint(tab == selectedTab ? Color(Constants.Color.interactive) : .secondary)
    }
}

#Preview {
    TabItem(tab: .chat, selectedTab: .constant(.chat))
}
