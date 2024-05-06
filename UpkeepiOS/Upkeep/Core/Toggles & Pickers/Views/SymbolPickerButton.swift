//
//  ApplianceIconPicker.swift
//  Upkeep
//
//  Created by Mustafa on 4/30/24.
//

import Foundation
import SwiftUI

struct SymbolPickerButton: View {
    @StateObject var viewModel: SymbolPickerButtonViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15.0)
                .fill(.background)
                .aspectRatio(1, contentMode: .fit)

            Image(systemName: viewModel.appliance.symbol.rawValue)
                .resizable()
                .scaledToFit()
                .symbolVariant(.fill)
                .padding()
                .foregroundStyle((viewModel.appliance.brand?.name.hashedToColor() ?? Color.accentColor).gradient)
        }
        .listRowBackground(Color.clear)
        .frame(maxWidth: .infinity, maxHeight: 120)
        .onTapGesture(perform: viewModel.openSheet)
        .sheet(isPresented: $viewModel.isPickingImage, content: {
            SymbolPicker(viewModel:
                SymbolPickerViewModel(appliance: $viewModel.appliance))
        })
    }
}
