//
//  ConditionalView+Generic.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import SwiftUI

struct ConditionalView<T: View>: View {
    let condition: Bool
    let content: () -> T
    var body: some View {
        if condition {
            content()
        } else {
            EmptyView()
        }
    }
}
