//
//  ApplianceItem.swift
//  Upkeep
//
//  Created by Mustafa on 4/28/24.
//

import Foundation
import SwiftData
import SwiftUI

struct ItemSymbol: View {
    let symbol: String
    let color: Color

    var body: some View {
        ZStack {
            Rectangle()
                .fill(color.gradient)
            Image(systemName: symbol)
                .resizable()
                .symbolVariant(.fill)
                .foregroundStyle(.white)
                .scaledToFit()
                .padding()
        }
        .frame(width: 60, height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct Item: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var appliance: Appliance

    var body: some View {
        HStack(spacing: 20) {
            ItemSymbol(symbol: appliance.symbol, color: appliance.brand.rawValue.hashedToColor())

            VStack(alignment: .leading) {
                Text(appliance.brand.rawValue)
                    .font(.system(.caption, weight: .bold))
                    .textCase(.uppercase)
                    .foregroundStyle(.secondary)
                    .fontDesign(.rounded)
                Text(appliance.name)
                    .font(.headline)
                Text("Purchased on \(appliance.purchaseDate.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year(.extended())))")
                    .font(.system(.subheadline))
                HStack {
                    let fileCount = appliance.manuals.count
                    Image(systemName: "folder")
                        .symbolVariant(.fill)
                    Text("\(fileCount) manual\(fileCount != 1 ? "s" : "")".capitalized)
                }
                .font(.system(.caption))
                .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }
}
