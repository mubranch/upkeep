//
//  DismissButton.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import SwiftUI

struct DismissButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}
