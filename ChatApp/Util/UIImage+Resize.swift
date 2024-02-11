//
//  UIImage+Resize.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import UIKit

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsImageRenderer(size: size).image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
