//
//  ToggleButton.swift
//  Upkeep
//
//  Created by Mustafa on 5/1/24.
//

import SwiftUI

struct ToggleButton: View {
    var label: String
    var symbol: String?

    @Binding var binding: Bool

    var body: some View {
        if let symbol = symbol {
            Button(label, systemImage: symbol) {
                self.binding.toggle()
            }
        } else {
            Button(label) {
                self.binding.toggle()
            }
        }
    }
}
