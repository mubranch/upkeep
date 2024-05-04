//
//  TogglePicker+Generic.swift
//  Upkeep
//
//  Created by Mustafa on 4/30/24.
//

import SwiftData
import SwiftUI

struct BrandTogglePicker: View {
    @Binding var selection: Brand?
    @Environment(\.editMode) var editMode
    @Query(sort: \Brand.name) var brands: [Brand]

    var body: some View {
        Text(selection?.name.capitalized ?? Copy.TogglePickers.noValueText)
            .foregroundStyle(Color.secondary)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                Menu(selection?.name.capitalized ?? Copy.TogglePickers.noValueText) {
                    ForEach(brands) { b in
                        Button(b.name.capitalized) {
                            selection = b
                        }.tag(b)
                    }
                }
                .disabled(brands.isEmpty)
            }
    }
}

struct CategoryTogglePicker: View {
    @Binding var selection: Category?
    @Environment(\.editMode) var editMode
    @Query(sort: \Category.title) var categories: [Category]

    var body: some View {
        Text(selection?.title.capitalized ?? Copy.TogglePickers.noValueText)
            .foregroundStyle(Color.secondary)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                Menu(selection?.title.capitalized ?? Copy.TogglePickers.noValueText) {
                    ForEach(categories) { c in
                        Button(c.title.capitalized) {
                            selection = c
                        }.tag(c)
                    }
                }
                .disabled(categories.isEmpty)
            }
    }
}
