//
//  UIImage+Base64.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import UIKit

extension UIImage {
    var base64String: String? {
        guard let imageData = jpegData(compressionQuality: 1.0)
        else {
            print("Failed to convert image to data")
            return nil
        }

        return imageData.base64EncodedString()
    }

    static func fromBase64(_ base64String: String?) -> UIImage? {
        guard
            let base64String,
            let imageData = Data(base64Encoded: base64String)
        else {
            print("Invalid base64 string")
            return nil
        }

        guard let image = UIImage(data: imageData)
        else {
            print("Unable to create image from data")
            return nil
        }

        return image
    }
}
