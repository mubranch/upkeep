//
//  SymbolPicker.swift
//  Upkeep
//
//  Created by Mustafa on 4/30/24.
//

import Foundation
import SwiftData
import SwiftUI

struct SymbolPicker: View {
    @StateObject var viewModel: SymbolPickerViewModel

    private let numberOfColumns = 4

    var body: some View {
        NavigationStack {
            ScrollView {
                let gridItemLayout: [GridItem] = Array(repeating: .init(.flexible()), count: numberOfColumns)

                LazyVGrid(columns: gridItemLayout) {
                    ForEach(DefaultSymbols.allCases, id: \.rawValue) { symbol in
                        Button(action: {
                            viewModel.changeSymbol(symbol)
                        }) {
                            symbol.image
                                .resizable()
                                .scaledToFit()
                                .symbolVariant(.fill)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                                .background(Color(uiColor: .secondarySystemBackground))
                                .foregroundStyle((viewModel.appliance.brand?.name.hashedToColor() ?? Color.accentColor).gradient)
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
                    Button("Dismiss", action: viewModel.dismiss)
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Appliance.self, Manual.self, configurations: .init(isStoredInMemoryOnly: true))
    var app = Appliance()
    container.mainContext.insert(app)
    return SymbolPicker(viewModel:
        SymbolPickerViewModel(appliance: .constant(app)))
        .modelContainer(container)
}
