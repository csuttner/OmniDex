//
//  PulsingCircleView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct PulsingCircleView: View {
    @State private var opacity = 0.0

    private let color: Color
    private let animation: Animation
    private let diameter: Double

    init(
        color: Color = .white,
        duration: Double = 0.35,
        delay: Double = 0.0,
        diameter: Double = 16.0
    ) {
        self.color = color
        self.diameter = diameter

        animation = Animation
            .easeInOut(duration: duration)
            .repeatForever()
            .delay(delay)
    }

    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: diameter, height: diameter)
                .opacity(opacity)
                .animation(animation, value: opacity)
                .onAppear {
                    opacity = 1
                }
        }
    }
}

struct PulsingCircleView_Previews: PreviewProvider {
    static var previews: some View {
        PulsingCircleView()
    }
}
