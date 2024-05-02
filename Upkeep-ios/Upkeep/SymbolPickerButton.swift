//
//  ApplianceIconPicker.swift
//  Upkeep
//
//  Created by Mustafa on 4/30/24.
//

import SwiftUI

struct SymbolPickerButton: View {
    @State private var isPickingImage = false
    @Bindable var appliance: Appliance
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15.0)
                .fill(.background)
                .aspectRatio(1, contentMode: .fit)

            Image(systemName: appliance.symbol)
                .resizable()
                .scaledToFit()
                .symbolVariant(.fill)
                .padding()
                .foregroundStyle(appliance.brand.rawValue.hashedToColor().gradient)
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
        .onTapGesture {
            isPickingImage.toggle()
        }
        .sheet(isPresented: $isPickingImage, content: {
            SymbolPicker(appliance: appliance)
        })
        .listRowBackground(Color.clear)
    }
}
