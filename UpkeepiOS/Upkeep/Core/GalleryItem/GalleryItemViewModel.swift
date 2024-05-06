//
//  GalleryItemViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/5/24.
//

import Foundation
import SwiftData
import SwiftUI

class GalleryItemViewModel: ObservableObject {
    var appliance: Appliance

    init(appliance: Appliance) {
        self.appliance = appliance
    }
}
