//
//  ToggleButton.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import SwiftUI

struct ToggleButton: View {
    @StateObject var viewModel: ToggleButtonViewModel

    var body: some View {
        HStack {
            if let symbol = viewModel.symbol {
                Image(systemName: symbol) // Displays the symbol if it exists
            }
            Text(viewModel.label)
            Toggle(isOn: $viewModel.bool) {
                Text("") // Empty Text as the label is already provided
            }
            .labelsHidden() // Hides the default label of the Toggle
        }
    }
}

#Preview {
    ToggleButton(viewModel: ToggleButtonViewModel(label: .constant("Hello"), bool: .constant(false)))
}
