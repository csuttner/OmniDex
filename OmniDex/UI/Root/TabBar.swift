//
//  TabBar.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/12/24.
//

import SwiftUI

struct TabBar: View {
    @Binding var tab: Tab
    
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(Tab.allCases) {
                TabItem(tab: $0, selectedTab: $tab)
            }
        }
        .background(.regularMaterial)
    }
}

#Preview {
    TabBar(tab: .constant(.chat))
}
