//
//  ChatInputBar.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/11/24.
//

import SwiftUI

struct ChatInputBar: View {
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
        VStack(alignment: .leading, spacing: 0) {
            if selectedImage != nil {
                ChatImagePreviewView(image: $selectedImage)
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
                    .padding([.leading], buttonDimension + stackSpacing)
                    
            }
            
            HStack(alignment: .center, spacing: stackSpacing) {
                ChatImagePickerButton(selectedImage: $selectedImage)
                    .frame(
                        width: buttonDimension,
                        height: buttonDimension
                    )
                
                TextField(Constants.Chat.message, text: $text)
                    .submitLabel(.send)
                    .cornerRadius(cornerRadius)
                    .padding([.leading, .trailing], 10)
                    .padding([.top, .bottom], 8)
                    .background(textFieldShape)
                    .onSubmit {
                        onSubmit?()
                    }
            }
        }
        .padding([.top, .bottom], 6)
        .padding([.leading, .trailing], 12)
        .background(.regularMaterial)
    }
}

#Preview {
    ChatInputBar(
        text: .constant(Constants.Chat.message),
        selectedImage: .constant(UIImage(named: "Lambo"))
    )
}
