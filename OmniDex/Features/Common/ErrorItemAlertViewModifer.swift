//
//  ErrorItemAlertViewModifer.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/5/24.
//

import SwiftUI

struct ErrorItemAlertViewModifer: ViewModifier {
    @Binding var errorItem: ErrorItem?
    
    func body(content: Content) -> some View {
        content
            .alert(errorItem?.title ?? "", isPresented: $errorItem.isSome) {
                Button("Ok") {
                    errorItem = nil
                }
            } message: {
                Text(errorItem?.message ?? "")
            }
    }
}

extension View {
    func alert(errorItem: Binding<ErrorItem?>) -> some View {
        modifier(ErrorItemAlertViewModifer(errorItem: errorItem))
    }
}
