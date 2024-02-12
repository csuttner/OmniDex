//
//  FlipGroup.swift
//  ChatApp
//
//  Created by Clay Suttner on 2/10/24.
//

import SwiftUI

@ViewBuilder
func FlipGroup(
    if value: Bool,
    @ViewBuilder _ content: @escaping () -> TupleView<(some View, some View)>
) -> some View {
    let pair = content()

    if value {
        TupleView((pair.value.1, pair.value.0))
    } else {
        TupleView((pair.value.0, pair.value.1))
    }
}
