//
//  ChatMessageShape.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct ChatMessageShape: Shape {
    private let bottomLeft: Bool
    private let bottomRight: Bool
    private let cornerRadius: Double
    
    init(isUser: Bool, cornerRadius: Double = 8) {
        self.cornerRadius = cornerRadius

        bottomLeft = isUser
        bottomRight = !isUser
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.size.width
        let height = rect.size.height
        let topLeftRadius = cornerRadius
        let topRightRadius = cornerRadius
        let bottomLeftRadius = bottomLeft ? cornerRadius : 0
        let bottomRightRadius = bottomRight ? cornerRadius : 0
        
        path.move(to: CGPoint(x: 0 + topLeftRadius, y: 0))

        path.addLine(to: CGPoint(x: width - topRightRadius, y: 0))
        path.addArc(center: CGPoint(x: width - topRightRadius, y: topRightRadius), radius: topRightRadius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        
        if bottomRight {
            path.addLine(to: CGPoint(x: width, y: height - bottomRightRadius))
            path.addArc(center: CGPoint(x: width - bottomRightRadius, y: height - bottomRightRadius), radius: bottomRightRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: width, y: height))
        }
        
        if bottomLeft {
            path.addLine(to: CGPoint(x: 0 + bottomLeftRadius, y: height))
            path.addArc(center: CGPoint(x: 0 + bottomLeftRadius, y: height - bottomLeftRadius), radius: bottomLeftRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: 0, y: height))
        }
        
        path.addLine(to: CGPoint(x: 0, y: 0 + topLeftRadius))
        path.addArc(center: CGPoint(x: 0 + topLeftRadius, y: 0 + topLeftRadius), radius: topLeftRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}
