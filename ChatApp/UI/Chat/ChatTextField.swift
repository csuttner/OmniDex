//
//  ChatTextField.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct ChatTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField(Constants.Chat.message, text: $text)
            .textFieldStyle(PillTextFieldStyle())
            .padding()
            .submitLabel(.send)
    }
}

#Preview {
    ChatTextField(
        text: .constant(Constants.Chat.message)
    )
}
