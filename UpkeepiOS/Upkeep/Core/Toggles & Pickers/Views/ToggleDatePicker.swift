//
//  ToggleDatePicker.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftUI

struct ToggleDatePicker: View {
    @Environment(\.editMode) var editMode
    @StateObject var viewModel: ToggleDatePickerViewModel

    var body: some View {
        Text(viewModel.selection.formatted(dateFormat))
            .foregroundStyle(Color.secondary)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                DatePicker(Copy.ToggleDatePicker.datePickerLabel, selection: $viewModel.selection, displayedComponents: [.date])
                    .labelsHidden()
            }
    }

    var dateFormat: Date.FormatStyle {
        .dateTime.day().month(.wide).year(.extended())
    }
}

#Preview {
    ToggleDatePicker(viewModel: ToggleDatePickerViewModel(selection: .constant(Date())))
}
