//
//  ImagePickerMenu.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import SwiftUI

enum ImageSource {
    case camera, library
}

struct ImagePickerMenu<Content: View>: View {
    @Binding var selectedImage: UIImage?
    
    let label: () -> Content
    
    @State private var imageSource: ImageSource?
    @State private var isPresented = false
    
    var body: some View {
        Menu {
            Button {
                imageSource = .camera
            } label: {
                Label(Constants.Chat.camera, systemImage: "camera")
            }

            Button {
                imageSource = .library
            } label: {
                Label(Constants.Chat.library, systemImage: "photo")
            }
            
        } label: {
            label()
        }
        .onChange(of: imageSource) {
            isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            ImagePicker(
                selectedImage: $selectedImage,
                imageSource: imageSource
            )
        }
    }
}
