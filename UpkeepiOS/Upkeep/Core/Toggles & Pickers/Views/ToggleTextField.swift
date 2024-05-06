//
//  ToggleTextField.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import SwiftUI

struct ToggleTextField: View {
    @Environment(\.editMode) var editMode
    @StateObject var viewModel: ToggleTextFieldViewModel

    var body: some View {
        Text(viewModel.text.isEmpty ? "--" : viewModel.text)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                TextField("00000000", text: $viewModel.text)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(Color.accentColor)
            }
    }
}

#Preview {
    ToggleTextField(viewModel: ToggleTextFieldViewModel(text: .constant("Hello")))
        .environment(\.editMode, .constant(.active))
        .padding()
        .border(.red)
        .padding()
}
