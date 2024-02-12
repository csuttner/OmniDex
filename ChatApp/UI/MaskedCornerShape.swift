//
//  MaskedCornerShape.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct MaskedCornerShape: Shape {
    var cornerRadius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )

        return Path(path.cgPath)
    }
}

extension MaskedCornerShape {
    init(cornerRadius: CGFloat, isUser: Bool) {
        self.cornerRadius = cornerRadius

        corners = isUser
            ? [.topLeft, .topRight, .bottomLeft]
            : [.topLeft, .topRight, .bottomRight]
    }
}
