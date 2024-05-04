//
//  ToggleTextField.swift
//  Upkeep
//
//  Created by Mustafa on 4/30/24.
//

import SwiftUI

struct ToggleTextField: View {
    @Binding var text: String

    @Environment(\.editMode) var editMode

    var body: some View {
        Text(text)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                TextField(text, text: $text)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(Color.accentColor)
            }
    }
}
