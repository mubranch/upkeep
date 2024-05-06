//
//  ToggleTextFieldViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftUI

class ToggleTextFieldViewModel: ObservableObject {
    @Binding var text: String

    init(text: Binding<String>) {
        self._text = text
    }
}
