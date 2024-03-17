//
//  ImagineRootContentView.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/17/24.
//

import SwiftUI

struct ImagineRootContentView: View {
    @Environment(ServiceProvider.self) private var serviceProvider
    @Environment(StoreProvider.self) private var storeProvider
    
    var creations: [ImageCreation]
    
    var body: some View {
        VStack {
            if creations.isEmpty {
                ContentUnavailableView(
                    "You have no saved images",
                    systemImage: "photo.stack"
                )
                .symbolRenderingMode(.multicolor)
                
            } else {
                ImagineRootGridView(creations: creations)
            }
        }
        .animation(.easeIn, value: creations)
    }
}

#Preview {
    ImagineRootContentView(creations: [])
        .environment(Mock.serviceProvider)
        .environment(Mock.storeProvider)
}
