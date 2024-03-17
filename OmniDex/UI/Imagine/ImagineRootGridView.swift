//
//  ImagineRootGridView.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/17/24.
//

import SwiftUI

struct ImagineRootGridView: View {
    var creations: [ImageCreation]
    
    var body: some View {
        let gridItem = GridItem(.flexible(), spacing: 8)
        
        ScrollView {
            LazyVGrid(columns: [gridItem, gridItem]) {
                ForEach(creations) { creation in
                    if
                        let imageData = creation.image,
                        let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
        }
        .contentMargins(8, for: .scrollContent)
    }
}

#Preview {
    ImagineRootGridView(
        creations: [
            Mock.imageCreation,
            Mock.imageCreation,
            Mock.imageCreation,
            Mock.imageCreation,
            Mock.imageCreation
        ]
    )
}
