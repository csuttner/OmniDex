//
//  SummarizeView.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/26/24.
//

import SwiftUI

struct SummarizeView: View {
    @Binding var tab: Tab
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(Constants.Tabs.summarize)
            
            Spacer()
            
            TabBar(tab: $tab)
        }
    }
}

#Preview {
    SummarizeView(tab: .constant(.summarize))
}
