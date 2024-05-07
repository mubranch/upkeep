//
//  ToggleButtonViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftUI

class ToggleButtonViewModel: ObservableObject {
    @Binding var label: String
    @Binding var symbol: String?
    @Binding var bool: Bool

    init(label: Binding<String>,
         symbol: Binding<String?> = .constant(nil),
         bool: Binding<Bool>)
    {
        self._label = label
        self._symbol = symbol
        self._bool = bool
    }
}
