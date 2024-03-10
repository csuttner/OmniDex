//
//  ErrorItemAlertViewModifer.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/5/24.
//

import SwiftUI

struct AlertItemViewModifier: ViewModifier {
    @Binding var item: AlertItem
    
    func body(content: Content) -> some View {
        if let message = item.message {
            content
                .alert(item.title, isPresented: $item.isPresented) {
                    Button("Ok") {
                        item.reset()
                    }
                } message: {
                    Text(message)
                }
            
        } else {
            content
                .alert(item.title, isPresented: $item.isPresented) {
                    Button("Ok") {
                        item.reset()
                    }
                }
        }
    }
}

extension View {
    func alert(item: Binding<AlertItem>) -> some View {
        modifier(AlertItemViewModifier(item: item))
    }
}
