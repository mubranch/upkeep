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

    var body: some View {
        Text(selection.formatted(dateFormat))
            .foregroundStyle(Color.secondary)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                DatePicker(Copy.ToggleDatePicker.datePickerLabel, selection: $selection, displayedComponents: [.date])
                    .labelsHidden()
            }
    }

    var dateFormat: Date.FormatStyle {
        .dateTime.day().month(.wide).year(.extended())
    }
}
