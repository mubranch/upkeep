//
//  TogglePicker+Generic.swift
//  Upkeep
//
//  Created by Mustafa on 4/30/24.
//

import SwiftUI

struct TogglePicker<T: ApplianceEnumProtocol>: View {
    @Environment(\.editMode) var editMode
    @Binding var selection: T

    var body: some View {
        Text(selection.formattedRawValue)
            .foregroundStyle(Color.secondary)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                Picker(T.self.title, selection: $selection) {
                    ForEach(T.allCases.compactMap { $0 }, id: \.rawValue) {
                        Text($0.formattedRawValue)
                            .tag($0)
                    }
                }.labelsHidden()
            }
    }
}
