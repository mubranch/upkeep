//
//  ApplianceType.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation

enum DefaultCategory: String, CategoryProtocol, CaseIterable {
    static var title = "Appliance Type"
    case refrigerator
    case oven
    case microwave
    case dishwasher
    case blender
    case toaster
    case coffeeMaker = "Coffee Maker"
    case foodProcessor = "Food Processor"
    case mixer
    case electricKettle = "Electric Kettle"

    case washingMachine = "Washing Machine"
    case dryer
    case iron
    case steamPress = "Steam Press"

    case vacuumCleaner = "Vacuum Cleaner"
    case steamCleaner = "Steam Cleaner"
    case carpetCleaner = "Carpet Cleaner"
    case floorPolisher = "Floor Polisher"

    case airConditioner = "Air Conditioner"
    case heater
    case humidifier
    case dehumidifier
    case fan
    case airPurifier = "Air Purifier"

    case hairDryer = "Hair Dryer"
    case electricShaver = "Electric Shaver"
    case electricToothbrush = "Electric Toothbrush"
    case hairStraightener = "Hair Straightener"
    case curlingIron = "Curling Iron"

    case television
    case homeTheaterSystem = "Home Theater System"
    case soundbar
    case dvdPlayer = "DVD Player"
    case gamingConsole = "Gaming Console"

    case computer
    case printer
    case scanner
    case faxMachine

    case garbageDisposal = "Garbage Disposal"
    case waterHeater = "Water Heater"
    case sewingMachine = "Sewing Machine"
    case electricFireplace = "Electric Fireplace"
    case electricBlanket = "Electric Blanket"

    case generic

    var title: String {
        self.rawValue
    }

    var id: String {
        self.rawValue
    }
}

extension Category {
    var symbol: DefaultSymbols {
        switch self.rawValue {
        case "refrigerator":
            return .refrigerator
        case "oven":
            return .oven
        case "microwave":
            return .microwave
        case "dishwasher":
            return .dishwasher
        case "blender":
            return .wrenchAndScrewdriverFill
        case "toaster":
            return .stove
        case "coffeeMaker":
            return .pc
        case "foodProcessor":
            return .display
        case "mixer":
            return .hifiSpeaker
        case "electricKettle":
            return .powerOutletTypeIFill
        case "washingMachine":
            return .washer
        case "dryer":
            return .dryer
        case "iron":
            return .wrenchAndScrewdriverFill
        case "steamPress":
            return .powerOutletTypeIFill
        case "vacuumCleaner":
            return .wrenchAndScrewdriverFill
        case "steamCleaner":
            return .videoProjector
        case "carpetCleaner":
            return .wrenchAndScrewdriverFill
        case "floorPolisher":
            return .wrenchAndScrewdriverFill
        case "airConditioner":
            return .airPurifier
        case "heater":
            return .verticalHeater
        case "humidifier":
            return .humidifier
        case "dehumidifier":
            return .dehumidifier
        case "fan":
            return .wrenchAndScrewdriverFill
        case "airPurifier":
            return .airPurifier
        case "hairDryer":
            return .wrenchAndScrewdriverFill
        case "electricShaver":
            return .wrenchAndScrewdriverFill
        case "electricToothbrush":
            return .wrenchAndScrewdriverFill
        case "hairStraightener":
            return .wrenchAndScrewdriverFill
        case "curlingIron":
            return .wrenchAndScrewdriverFill
        case "television":
            return .display
        case "homeTheaterSystem":
            return .hifiSpeaker
        case "soundbar":
            return .hifiSpeaker
        case "dvdPlayer":
            return .wrenchAndScrewdriverFill
        case "gamingConsole":
            return .gameController
        case "computer":
            return .pc
        case "printer":
            return .printer
        case "scanner":
            return .scanner
        case "faxMachine":
            return .faxMachine
        case "garbageDisposal":
            return .wrenchAndScrewdriverFill
        case "waterHeater":
            return .powerOutletTypeIFill
        case "sewingMachine":
            return .wrenchAndScrewdriverFill
        case "electricFireplace":
            return .powerOutletTypeIFill
        case "electricBlanket":
            return .wrenchAndScrewdriverFill
        default:
            return .wrenchAndScrewdriverFill
        }
    }
}
