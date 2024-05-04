//
//  ApplianceItem.swift
//  Upkeep
//
//  Created by Mustafa on 4/28/24.
//

import Foundation
import SwiftData
import SwiftUI

struct ApplianceGalleryItemSymbol: View {
    @Bindable var appliance: Appliance

    var body: some View {
        ZStack {
            Rectangle()
                .fill((appliance.brand?.name.hashedToColor() ?? Color.accentColor).gradient)
            appliance.symbol.image
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

struct ApplianceGalleryItem: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var appliance: Appliance

    var body: some View {
        HStack(spacing: 20) {
            ApplianceGalleryItemSymbol(appliance: appliance)

            VStack(alignment: .leading) {
                Text(appliance.brand?.name ?? "No Name")
                    .font(.system(.caption, weight: .bold))
                    .textCase(.uppercase)
                    .foregroundStyle(.secondary)
                    .fontDesign(.rounded)
                    .lineLimit(1)
                Text(appliance.name)
                    .font(.headline)
                Text("\(appliance.modelNumber)")
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
