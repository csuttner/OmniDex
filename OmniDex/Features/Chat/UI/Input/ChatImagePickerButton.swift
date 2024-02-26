//
//  ChatImagePickerButton.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import SwiftUI

struct ChatImagePickerButton: View {
    @Binding var selectedImage: UIImage?

    @State private var isImagePickerPresented = false
    @State private var willUseCamera = false

    var body: some View {
        Button {
            isImagePickerPresented.toggle()
        } label: {
            Image(
                systemName: willUseCamera
                    ? "camera.circle.fill"
                    : "photo.circle.fill"
            )
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color(Constants.Color.interactive))
        }
        .frame(width: 36, height: 36)
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(
                selectedImage: $selectedImage,
                willUseCamera: willUseCamera
            )
        }
        .contextMenu {
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
        }
    }
}

#Preview {
    ChatImagePickerButton(
        selectedImage: .constant(nil)
    )
}
