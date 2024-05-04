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
    @Environment(\.dismiss) var dismissAction
    @Bindable var appliance: Appliance

    private let numberOfColumns = 4

    var body: some View {
        NavigationStack {
            ScrollView {
                let gridItemLayout: [GridItem] = Array(repeating: .init(.flexible()), count: numberOfColumns)

                LazyVGrid(columns: gridItemLayout) {
                    ForEach(DefaultSymbols.allCases, id: \.rawValue) { symbol in
                        Button(action: {
                            // Set selected symbol to the appliance and dismiss the view
                            appliance.symbol = symbol
                            dismissAction()
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
            .navigationTitle(Copy.SymbolPicker.pageTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
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
