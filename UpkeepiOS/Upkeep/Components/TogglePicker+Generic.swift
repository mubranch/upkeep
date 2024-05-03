//
//  TogglePicker+Generic.swift
//  Upkeep
//
//  Created by Mustafa on 4/30/24.
//

import SwiftData
import SwiftUI

struct BrandTogglePicker: View {
    @Environment(\.editMode) var editMode
    @Binding var selection: Brand?
    @Query(sort: \Brand.name) var brands: [Brand]

    var body: some View {
        Text(selection?.name.capitalized ?? brands.first?.name.capitalized ?? "Not Set")
            .foregroundStyle(Color.secondary)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                Menu(selection?.name.capitalized ?? brands.first?.name.capitalized ?? "Not Set") {
                    ForEach(brands, id: \.rawValue) { b in
                        Button(b.name.capitalized) {
                            selection = b
                        }.tag(b)
                    }
                }
            }
    }
}

struct CategoryTogglePicker: View {
    @Environment(\.editMode) var editMode
    @Binding var selection: Category?
    @Query(sort: \Category.title) var categories: [Category]

    var body: some View {
        Text(selection?.title.capitalized ?? categories.first?.title.capitalized ?? "Not Set")
            .foregroundStyle(Color.secondary)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                Menu(selection?.title.capitalized ?? categories.first?.title.capitalized ?? "Not Set") {
                    ForEach(categories, id: \.rawValue) { c in
                        Button(c.title.capitalized) {
                            selection = c
                        }.tag(c)
                    }
                }
            }
    }
}
