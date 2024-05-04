//
//  ApplianceIconPicker.swift
//  Upkeep
//
//  Created by Mustafa on 4/30/24.
//

import SwiftUI

struct SymbolPickerButton: View {
    @Bindable var appliance: Appliance

    @State private var pickingImage = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15.0)
                .fill(.background)
                .aspectRatio(1, contentMode: .fit)

            Image(systemName: appliance.symbol.rawValue)
                .resizable()
                .scaledToFit()
                .symbolVariant(.fill)
                .padding()
                .foregroundStyle((appliance.brand?.name.hashedToColor() ?? Color.accentColor).gradient)
        }
        .listRowBackground(Color.clear)
        .frame(maxWidth: .infinity, maxHeight: 120)
        .onTapGesture {
            pickingImage.toggle()
        }
        .sheet(isPresented: $pickingImage, content: {
            SymbolPicker(appliance: appliance)
        })
    }
}
