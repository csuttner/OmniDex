//
//  ImagePickerButton.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import SwiftUI

struct ImagePickerCircle: View {
    @Binding var willUseCamera: Bool

    var body: some View {
        Image(
            systemName: willUseCamera
                ? "camera.circle.fill"
                : "photo.circle.fill"
        )
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(Color(Constants.Color.interactive))
        .frame(width: 36, height: 36)
    }
}

#Preview {
    ImagePickerCircle(willUseCamera: .constant(false))
}
