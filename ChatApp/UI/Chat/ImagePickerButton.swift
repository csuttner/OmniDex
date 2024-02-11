//
//  ImagePickerView.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import SwiftUI

struct ImagePickerButton: View {
    @Binding var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    var body: some View {
        Button(action: {
            isImagePickerPresented.toggle()
        }) {
            Image(systemName: "photo.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(Constants.Color.interactive))
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}

#Preview {
    ImagePickerButton(selectedImage: .constant(nil))
}
