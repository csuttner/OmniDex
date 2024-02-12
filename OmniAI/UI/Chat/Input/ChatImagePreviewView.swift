//
//  ChatImagePreviewView.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import SwiftUI

struct ChatImagePreviewView: View {
    @Binding var image: UIImage?

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Button(action: {
                image = nil
            }) {
                Image(systemName: "multiply.circle.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .padding(2)
                    .foregroundColor(.gray)
                    .background()
                    .clipShape(.circle)
                    .padding(4)
            }
        }
    }
}

#Preview {
    ChatImagePreviewView(image: .constant(UIImage(named: "Lambo")))
}
