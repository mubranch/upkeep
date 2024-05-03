//
//  ToggleDatePicker.swift
//  Upkeep
//
//  Created by Mustafa on 4/30/24.
//

import SwiftUI

struct ToggleDatePicker: View {
    @Environment(\.editMode) var editMode
    @Binding var selection: Date

    var dateFormat: Date.FormatStyle {
        .dateTime.day().month(.wide).year(.extended())
    }

    var body: some View {
        Text(selection.formatted(dateFormat))
            .foregroundStyle(Color.secondary)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                DatePicker("Last Maintenace", selection: $selection, displayedComponents: [.date])
                    .labelsHidden()
            }
    }
}
