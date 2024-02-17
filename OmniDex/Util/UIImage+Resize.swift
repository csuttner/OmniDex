//
//  UIImage+Resize.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import UIKit

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        let aspectFitSize = self.size.aspectFill(to: size)

        return UIGraphicsImageRenderer(size: size).image { _ in
            let rect = CGRect(
                origin: CGPoint(
                    x: (size.width - aspectFitSize.width) / 2.0,
                    y: (size.height - aspectFitSize.height) / 2.0
                ),
                size: aspectFitSize
            )

            self.draw(in: rect)
        }
    }
}

extension CGSize {
    func aspectFill(to boundingSize: CGSize) -> CGSize {
        let aspectRatio = width / height
        let boundingAspectRatio = boundingSize.width / boundingSize.height
        var newSize = boundingSize

        if aspectRatio > boundingAspectRatio {
            newSize.width = boundingSize.height * aspectRatio
        } else {
            newSize.height = boundingSize.width / aspectRatio
        }

        return newSize
    }
}
