//
//  EllipsesLoadingView.swift
//  ChatApp
//
//  Created by Clay Suttner on 4/23/23.
//

import SwiftUI

struct EllipsesLoadingView: View {
    var body: some View {
        HStack {
            PulsingCircleView()
            PulsingCircleView(delay: 0.2)
            PulsingCircleView(delay: 0.4)
        }
    }
}

struct EllipsesLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        EllipsesLoadingView()
    }
}
