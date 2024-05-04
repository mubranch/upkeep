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
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismissAction
    @Query var appliances: [Appliance]
    @Bindable var manual: Manual

    var body: some View {
        NavigationStack {
            List {
                LabeledContent("Name") {
                    TextField("New Manual", text: $manual.name)
                        .multilineTextAlignment(.trailing)
                }

                LabeledContent("Appliance") {
                    Menu(manual.appliance?.name ?? "Not Set") {
                        ForEach(appliances) { appliance in
                            Button(appliance.name) {
                                manual.appliance = appliance
                            }
                            .tag(appliance)
                        }
                    }
                    .menuStyle(.button)
                }

                TextField("URL", text: $manual.urlString).disabled(true)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        modelContext.delete(manual)
                        dismissAction()
                    }
                }

                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        modelContext.insert(manual)
                        dismissAction()
                    }.disabled(manual.name.isEmpty || manual.appliance == nil)
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Appliance.self, Manual.self, Brand.self, Category.self, configurations: .init(isStoredInMemoryOnly: true))
    let app = Appliance(name: "Hi")
    container.mainContext.insert(app)
    let manual = Manual(name: String.none, urlString: "https://data2.manualslib.com/pdf7/302/30121/3012079-kitchenaid/krff507hps.pdf?5c7cf92795281981af25aec0224b3a20", file: try! Data(contentsOf: URL(string: "https://data2.manualslib.com/pdf7/302/30121/3012079-kitchenaid/krff507hps.pdf?5c7cf92795281981af25aec0224b3a20")!))
    container.mainContext.insert(manual)
    return ManualEditor(manual: manual)
        .modelContainer(container)
}
