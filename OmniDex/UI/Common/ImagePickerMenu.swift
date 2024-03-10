//
//  ImagePickerMenu.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import SwiftUI

struct ImagePickerMenu<Content: View>: View {
    @Binding var selectedImage: UIImage?
    @Binding var willUseCamera: Bool
    
    let label: () -> Content
    
    @State private var isImagePickerPresented = false
    
    var body: some View {
        Menu {
            Button {
                willUseCamera = false
                isImagePickerPresented.toggle()
            } label: {
                Label(Constants.Chat.library, systemImage: "photo")
            }
            
            Button {
                willUseCamera = true
                isImagePickerPresented.toggle()
            } label: {
                Label(Constants.Chat.camera, systemImage: "camera")
            }
            
        } label: {
            label()
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(
                selectedImage: $selectedImage,
                willUseCamera: willUseCamera
            )
        }
    }
}
