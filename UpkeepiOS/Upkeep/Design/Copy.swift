//
//  Copy.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation

import Foundation

enum Copy {
    enum Appliance {
        static let brandLabel = NSLocalizedString("Brand", comment: "Label for appliance brand")
        static let typeLabel = NSLocalizedString("Type", comment: "Label for appliance type")
        static let modelNumberLabel = NSLocalizedString("Model Number", comment: "Label for appliance model number")
        static let lastMaintenanceLabel = NSLocalizedString("Last Maintenance", comment: "Label for the last maintenance date of an appliance")
        static let purchasedDateLabel = NSLocalizedString("Purchase Date", comment: "Label for the purchase date of an appliance")
        static let warrantyExpirationLabel = NSLocalizedString("Warranty Expiration", comment: "Label for the warranty expiration date of an appliance")
        static let serialNumberLabel = NSLocalizedString("Serial Number", comment: "Label for the serial number of an appliance")
        static let manualsLabel = NSLocalizedString("Manuals", comment: "Label for accessing manuals of an appliance")
        static let browserButtonLabel = NSLocalizedString("Find Manual", comment: "Button label for finding manuals online")
    }

    enum Gallery {
        static let pageTitle = NSLocalizedString("Appliances", comment: "Title for the appliances page")
        static let primaryActionLabel = NSLocalizedString("Add Appliances", comment: "Button label for adding new appliances")
        static let primaryActionSymbol = "plus"
    }

    enum ToggleDatePicker {
        static let datePickerLabel = NSLocalizedString("Last maintenance date", comment: "Label for selecting the last maintenance date on a date picker")
    }

    enum QuickCreate {
        static let modelNumberPrompt = NSLocalizedString("Enter a model number", comment: "Prompt for entering a model number in a text field")
        static let brandPickerMenuLabel = NSLocalizedString("Brand", comment: "Label for brand selection menu")
        static let brandPickerPlaceholder = NSLocalizedString("Select a brand", comment: "Placeholder text for brand selection menu")
        static let searchModelLabel = NSLocalizedString("Search", comment: "Label for the search button")
        static let dismissActionLabel = NSLocalizedString("Cancel", comment: "Label for cancel button in forms")
        static let manualModelLabel = NSLocalizedString("Advanced", comment: "Label for selecting advanced options")
        static let searchModelSymbol = "magnifyingglass"
    }

    enum SimpleFilter {
        static let selectedBrandSymbol = "checkmark"
        static let clearFilterSymbol = "xmark"
        static let clearFilterLabel = NSLocalizedString("Clear", comment: "Label for a button that clears filters")
        static let sortButtonSymbol = "line.3.horizontal.decrease"
    }

    enum SymbolPicker {
        static let pageTitle = NSLocalizedString("Symbols", comment: "Title for the page where symbols are chosen")
    }

    enum TogglePickers {
        static let noValueText = NSLocalizedString("Not set", comment: "Text displayed when no value is set in pickers")
    }

    enum Settings {
        static let pageTitle = NSLocalizedString("Settings", comment: "Title for the settings page")
    }
}
