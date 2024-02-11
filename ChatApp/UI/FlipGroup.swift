//
//  FlipGroup.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

@ViewBuilder
func FlipGroup<V1: View, V2: View>(
    if value: Bool,
    @ViewBuilder _ content: @escaping () -> TupleView<(V1, V2)>
) -> some View {
    let pair = content()

    if value {
        TupleView((pair.value.1, pair.value.0))
    } else {
        TupleView((pair.value.0, pair.value.1))
    }
}
