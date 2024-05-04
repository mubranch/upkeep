//
//  Copy.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation

enum Copy {
    enum Appliance {
        static let brandLabel = "Brand"
        static let typeLabel = "Type"
        static let modelNumberLabel = "Model Number"
        static let lastMaintenanceLabel = "Last Maintenance"
        static let purchasedDateLabel = "Purchase Date"
        static let warrantyExpirationLabel = "Warranty Expiration"
        static let serialNumberLabel = "Serial Number"
        static let manualsLabel = "Manuals"
        static let browserButtonLabel = "Find Manual"
    }
}

extension Copy {
    enum Gallery {
        static let pageTitle = "Appliances"
        static let primaryActionLabel = "Add Appliances"
        static let primaryActionSymbol = "plus"
    }
}

extension Copy {
    enum ToggleDatePicker {
        static let datePickerLabel = "Last maintenance date"
    }
}

extension Copy {
    enum Interstitial {
        static let modelNumberPrompt = "Enter a model number"
        static let brandPickerMenuLabel = "Brand"
        static let brandPickerPlaceholder = "Select a brand"
        static let saveModelLabel = "Save"
    }
}

extension Copy {
    enum SimpleFilter {
        static let selectedBrandSymbol = "checkmark"
        static let clearFilterSymbol = "xmark"
        static let clearFilterLabel = "Clear"
        static let sortButtonSymbol = "line.3.horizontal.decrease"
    }
}

extension Copy {
    enum SymbolPicker {
        static let pageTitle = "Symbols"
    }
}

extension Copy {
    enum TogglePickers {
        static let noValueText = "Not set"
    }
}

extension Copy {
    enum Settings {
        static let pageTitle = "Settings"
    }
}
