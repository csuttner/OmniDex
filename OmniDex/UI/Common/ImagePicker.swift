//
//  ImagePicker.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedImage: UIImage?
    
    let imageSource: ImageSource?

    class Coordinator:
        NSObject,
        UINavigationControllerDelegate,
        UIImagePickerControllerDelegate,
        PHPickerViewControllerDelegate {

        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(
            _: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if
                let image = info[.originalImage] as? UIImage,
                let resizedImage = image.resize(to: .lowResSize) {
                parent.selectedImage = resizedImage
            }

            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_: UIImagePickerController) {
            parent.dismiss()
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard
                let provider = results.first?.itemProvider,
                provider.canLoadObject(ofClass: UIImage.self) else {
                parent.dismiss()
                return
            }

            provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                DispatchQueue.main.async {
                    self?.parent.selectedImage = image as? UIImage
                    self?.parent.dismiss()
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<ImagePicker>
    ) -> UIViewController {
        if imageSource == .camera {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = .camera
            return picker
            
        } else {
            let picker = PHPickerViewController(configuration: PHPickerConfiguration())
            picker.delegate = context.coordinator
            return picker
        }
    }

    func updateUIViewController(
        _: UIViewController,
        context _: UIViewControllerRepresentableContext<ImagePicker>
    ) {}
}

private extension CGSize {
    static let lowResSize = CGSize(width: 512, height: 512)
}
