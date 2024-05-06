//
//  ManualEditor.swift
//  Upkeep
//
//  Created by Mustafa on 4/28/24.
//

import Foundation
import SwiftData
import SwiftUI

struct ManualDetail: View {
    @StateObject var viewModel: ManualDetailViewModel

    var body: some View {
        NavigationStack {
            List {
                LabeledContent("Name") {
                    TextField("New Manual", text: $viewModel.manual.name)
                        .multilineTextAlignment(.trailing)
                }

                LabeledContent("Appliance") {
                    Menu(viewModel.manual.appliance?.name ?? "Not Set") {
                        ForEach($viewModel.appliances) { $appliance in
                            Button(appliance.name) {
                                viewModel.selectAppliance(appliance: appliance)
                            }
                            .tag(appliance)
                        }
                    }
                    .menuStyle(.button)
                }

                LabeledContent("URL") {
                    Text(viewModel.manual.urlString)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", action: viewModel.cancel)
                }

                ToolbarItem(placement: .primaryAction) {
                    Button("Save", action: viewModel.save)
                        .disabled(viewModel.saveIsDisabled)
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

    return ManualDetail(viewModel: ManualDetailViewModel(appliance: app,
                                                         manual: manual,
                                                         modelContext: container.mainContext))
        .modelContainer(container)
}
