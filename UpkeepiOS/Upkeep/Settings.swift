//
//  Settings.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationStack {
            List {
                Toggle("Disable AI Search", isOn: .constant(false)).disabled(true)
            }
            .navigationTitle(Copy.Settings.pageTitle)
        }
    }
}

#Preview {
    Settings()
}
