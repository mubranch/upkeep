//
//  GalleryItemView.swift
//  Upkeep
//
//  Created by Mustafa on 5/5/24.
//

import SwiftData
import SwiftUI

struct GalleryItemView: View {
    @StateObject var viewModel: GalleryItemViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                symbol
                content
            }
        }
    }

    var symbol: some View {
        ZStack {
            Rectangle()
                .fill((viewModel.appliance.brand?.name.hashedToColor() ?? Color.accentColor).gradient)
            viewModel.appliance.symbol.image
                .resizable()
                .symbolVariant(.fill)
                .foregroundStyle(.white)
                .scaledToFit()
                .padding()
        }
        .frame(width: 60, height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    var content: some View {
        VStack(alignment: .leading) {
            Text(viewModel.appliance.brand?.name ?? "No Name")
                .font(.system(.caption, weight: .bold))
                .textCase(.uppercase)
                .foregroundStyle(.secondary)
                .fontDesign(.rounded)
                .lineLimit(1)
            Text(viewModel.appliance.name)
                .font(.headline)
            Text("\(viewModel.appliance.modelNumber)")
            HStack {
                let fileCount = viewModel.appliance.manuals.count
                Image(systemName: "folder")
                    .symbolVariant(.fill)
                Text("\(fileCount) manual\(fileCount != 1 ? "s" : "")".capitalized)
            }
            .font(.system(.caption))
            .foregroundStyle(.secondary)
        }
    }
}
