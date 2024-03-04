//
//  ConversationInputBar.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import SwiftUI

struct ConversationInputBar: View {
    @Binding var text: String
    @Binding var selectedImage: UIImage?

    var onSubmit: (() -> Void)?

    private let buttonDimension: CGFloat = 36
    private let stackSpacing: CGFloat = 6
    private let cornerRadius: CGFloat = 20

    @ViewBuilder
    private var textFieldShape: some View {
        if selectedImage == nil {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(.gray)
        } else {
            MaskedCornerShape(
                cornerRadius: cornerRadius,
                corners: [.bottomLeft, .bottomRight]
            )
            .stroke(.gray)
        }
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: stackSpacing) {
            ImagePickerButton(selectedImage: $selectedImage)
                .padding(.bottom, 1)
            
            VStack(alignment: .leading, spacing: 0) {
                if selectedImage != nil {
                    ImagePreviewView(image: $selectedImage)
                        .padding(10)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            MaskedCornerShape(
                                cornerRadius: cornerRadius,
                                corners: [.topLeft, .topRight]
                            )
                            .stroke(.gray)
                        )
                }

                HStack(alignment: .bottom, spacing: 10) {
                    TextField(
                        Constants.Chat.message,
                        text: $text,
                        axis: .vertical
                    )
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    
                    if !text.isEmpty {
                        Button {
                            onSubmit?()
                        } label: {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .foregroundStyle(Color(Constants.Color.interactive))
                                .frame(width: 30, height: 30)
                        }
                        .padding(4)
                    }
                }
                .background(textFieldShape)
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(.regularMaterial)
    }
}

#Preview {
    ConversationInputBar(
        text: .constant(PreviewConstants.nearbyLocations),
        selectedImage: .constant(UIImage(named: "Lambo"))
    )
}

#Preview {
    ConversationInputBar(
        text: .constant(PreviewConstants.glad),
        selectedImage: .constant(nil)
    )
}
