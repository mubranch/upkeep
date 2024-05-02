//
//  ManualEditor.swift
//  Upkeep
//
//  Created by Mustafa on 4/28/24.
//

import Foundation
import SwiftData
import SwiftUI

struct ManualEditor: View {
    @Environment(\.dismiss) var dismiss
    @Query var appliances: [Appliance]
    @Bindable var manual: Manual

    var body: some View {
        NavigationStack {
            List {
                TextField(manual.name, text: $manual.name)
                    .listRowBackground(Color(uiColor: .secondarySystemFill))
                Picker("Appliance", selection: $manual.appliance) {
                    ForEach(appliances) { appliance in
                        Text(appliance.name)
                            .tag(appliance)
                    }
                }
                .listRowBackground(Color(uiColor: .secondarySystemFill))
                TextField(manual.type, text: $manual.type)
                    .listRowBackground(Color(uiColor: .secondarySystemFill))
            }
            .navigationTitle("Edit")
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}
