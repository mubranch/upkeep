//
//  Toggles.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData
import SwiftUI

struct BrandTogglePicker: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var viewModel: TogglePickerViewModel

    var body: some View {
        Text(viewModel.selectedBrand?.name.capitalized ?? Copy.TogglePickers.noValueText)
            .foregroundStyle(Color.secondary)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                Menu(viewModel.selectedBrand?.name.capitalized ?? Copy.TogglePickers.noValueText) {
                    ForEach(viewModel.brands) { brand in
                        Button(brand.name.capitalized) {
                            viewModel.selectedBrand = brand
                        }
                    }
                }
                .disabled(viewModel.isBrandFilterDisabled)
            }
    }
}

struct CategoryTogglePicker: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var viewModel: TogglePickerViewModel

    var body: some View {
        Text(viewModel.selectedCategory?.title.capitalized ?? Copy.TogglePickers.noValueText)
            .foregroundStyle(Color.secondary)
            .if(editMode?.wrappedValue.isEditing == true) { _ in
                Menu(viewModel.selectedCategory?.title.capitalized ?? Copy.TogglePickers.noValueText) {
                    ForEach(viewModel.categories) { category in
                        Button(category.title.capitalized) {
                            viewModel.selectedCategory = category
                        }
                    }
                }
                .disabled(viewModel.isCategoryFilterDisabled)
            }
    }
}
