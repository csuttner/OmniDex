//
//  PillTextFieldStyle.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

struct PillTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.regularMaterial)
                    .background(.thinMaterial)
            )
            .cornerRadius(20)
    }
}
