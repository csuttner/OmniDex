//
//  UIImage+ToBase64.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import UIKit

extension UIImage {
    var base64String: String? {
        // Convert UIImage to Data
        guard let imageData = jpegData(compressionQuality: 1.0) else {
            print("Failed to convert image to data")
            return nil
        }
        
//        print("Converted image:", imageData.base64EncodedString())
        
        // Convert Data to base64 string
        return imageData.base64EncodedString()
    }

    static func fromBase64(_ base64String: String) -> UIImage? {
        // Check if the base64 string is valid
        guard let imageData = Data(base64Encoded: base64String) else {
            print("Invalid base64 string")
            return nil
        }
        
        // Create UIImage from the decoded data
        guard let image = UIImage(data: imageData) else {
            print("Unable to create image from data")
            return nil
        }
        
        return image
    }
}
