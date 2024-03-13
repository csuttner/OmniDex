//
//  TranslateView.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/26/24.
//

import SwiftUI

struct TranslateView: View {
    @Binding var tab: Tab
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(Constants.Tabs.translate)
            
            Spacer()
            
            TabBar(tab: $tab)
        }
    }
}

#Preview {
    ImagineView(tab: .constant(.translate))
}
