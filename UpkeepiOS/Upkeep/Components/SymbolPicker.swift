//
//  SymbolPicker.swift
//  Upkeep
//
//  Created by Mustafa on 4/30/24.
//

import SwiftData
import SwiftUI

// A view for picking an image symbol for an appliance
struct SymbolPicker: View {
    @Bindable var appliance: Appliance

    // Environment variable for dismissing the view
    @Environment(\.dismiss) var dismiss

    // State variable for search text
    @State private var searchText = ""

    // Computed property for search results based on search text
    var searchResults: [DefaultSymbols] {
        if searchText.isEmpty {
            return DefaultSymbols.allCases
        } else {
            return DefaultSymbols.allCases.filter {
                $0.rawValue.lowercased().contains(searchText.lowercased())
            }
        }
    }

    // Constants for grid layout
    private let numberOfColumns = 4

    var body: some View {
        NavigationStack {
            ScrollView {
                let gridItemLayout: [GridItem] = Array(repeating: .init(.flexible()), count: numberOfColumns)

                LazyVGrid(columns: gridItemLayout) {
                    // Iterate over search results to display symbol buttons
                    ForEach(searchResults, id: \.self) { symbol in
                        Button(action: {
                            // Set selected symbol to the appliance and dismiss the view
                            appliance.symbol = symbol
                            dismiss()
                        }) {
                            symbol.image
                                .resizable()
                                .scaledToFit()
                                .symbolVariant(.fill)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                                .background(Color(uiColor: .secondarySystemBackground))
                                .foregroundStyle((appliance.brand?.name.hashedToColor() ?? Color.accentColor).gradient)
                                .cornerRadius(15)
                        }
                        .buttonStyle(.plain)
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .contentMargins(.horizontal, 15, for: .scrollContent)
            .navigationTitle("Symbols")
//            .searchable(text: $searchText) // Enable search with text binding
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // Dismiss button in the navigation bar leading position

                    DismissButton()
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Appliance.self, Manual.self, configurations: .init(isStoredInMemoryOnly: true))
    let app = Appliance()
    container.mainContext.insert(app)
    return SymbolPicker(appliance: app)
        .modelContainer(container)
}
