//
//  ImagineView.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/26/24.
//

import SwiftUI

struct ImagineView: View {
    @Binding var tab: Tab
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(Constants.Tabs.imagine)
            
            Spacer()
            
            TabBar(tab: $tab)
        }
    }
}

#Preview {
    ImagineView(tab: .constant(.imagine))
}
