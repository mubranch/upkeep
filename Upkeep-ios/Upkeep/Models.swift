//
//  Models.swift
//  Upkeep
//
//  Created by Mustafa on 4/22/24.
//

import Foundation
import SwiftData
import SwiftUI

protocol ApplianceEnumProtocol: Codable, CaseIterable, Hashable {
    var rawValue: String { get }
    static var title: String { get }
    var formattedRawValue: String { get }
}

@Model
final class Manual: Identifiable {
    var id = UUID().uuidString
    var name: String
    var type: String
    var file: Data
    var appliance: Appliance?

    init(appliance: Appliance? = nil,
         name: String,
         type: String,
         file: Data)
    {
        self.appliance = appliance
        self.name = name
        self.type = type
        self.file = file
    }
}

@Model
final class Appliance: Identifiable {
    var id = UUID().uuidString
    var name: String
    var type: ApplianceType
    var brand: ApplianceBrand
    var modelNumber: String
    var serialNumber: String
    var purchaseDate: Date
    var warrantyExpirationDate: Date
    var lastMaintenaceDate: Date
    var symbol: ApplianceSymbol
    var manuals: [Manual]

    init(name: String = "Refrigerator",
         type: ApplianceType = ApplianceType.allCases.randomElement()!,
         brand: ApplianceBrand? = ApplianceBrand.allCases.randomElement()!,
         modelNumber: String? = "00000000",
         serialNumber: String? = "00000000",
         purchaseDate: Date = Date(),
         warrantyExpirationDate: Date = Date(),
         lastMaintenaceDate: Date = Date(),
         symbol: ApplianceSymbol? = nil,
         manuals: [Manual] = [Manual]())
    {
        self.name = name
        self.type = type
        self.brand = brand ?? ApplianceBrand.generic
        self.modelNumber = modelNumber ?? "00000000"
        self.serialNumber = serialNumber ?? "00000000"
        self.purchaseDate = purchaseDate
        self.warrantyExpirationDate = warrantyExpirationDate
        self.lastMaintenaceDate = lastMaintenaceDate
        self.symbol = symbol != nil ? symbol! : type.symbol
        self.manuals = manuals
    }
}

enum ApplianceType: String, ApplianceEnumProtocol {
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

    var formattedRawValue: String {
        self.rawValue.capitalized
    }
}

enum ApplianceBrand: String, ApplianceEnumProtocol {
    static var title = "Appliance Brand"
    case samsung = "Samsung"
    case lg = "LG"
    case whirlpool = "Whirlpool"
    case geAppliances = "GE Appliances"
    case bosch = "Bosch"
    case electrolux = "Electrolux"
    case frigidaire = "Frigidaire"
    case maytag = "Maytag"
    case kitchenAid = "KitchenAid"
    case panasonic = "Panasonic"
    case sharp = "Sharp"
    case haier = "Haier"
    case miele = "Miele"
    case siemens = "Siemens"
    case toshiba = "Toshiba"
    case amana = "Amana"
    case hotpoint = "Hotpoint"
    case fisherPaykel = "Fisher & Paykel"
    case kenmore = "Kenmore"
    case daewoo = "Daewoo"
    case hitachi = "Hitatchi"
    case westinghouse = "Westinghouse"
    case zanussi = "Zanussi"
    case hisense = "Hisense"
    case hoover = "Hoover"
    case candy = "Candy"
    case beko = "Beko"
    case indesit = "Indesit"
    case subZero = "Sub-Zero"
    case viking = "Viking"
    case thermador = "Thermador"
    case dacor = "Dacor"
    case liebherr = "Liebherr"
    case jennAir = "Jenn-Air"
    case wolf = "Wolf"
    case blomberg = "Blomberg"
    case gaggenau = "Gaggenau"
    case grundig = "Grundig"
    case rca = "RCA"
    case insignia = "Insignia"
    case vestel = "Vestel"
    case kelvinator = "Kelvinator"
    case admiral = "Admiral"
    case danby = "Danby"
    case magicChef = "Magic Chef"
    case avanti = "Avanti"
    case summit = "Summit"
    case edgeStar = "Edge Star"
    case sunbeam = "Sunbeam"
    case oster = "Oster"
    case blackDecker = "Black & Decker"
    case braun = "Braun"
    case cuisinart = "Cuisinart"
    case hamiltonBeach = "Hamilton Beach"
    case breville = "Breville"
    case presto = "Presto"
    case ninja = "Ninja"
    case farberware = "Farberware"
    case georgeForeman = "George Foreman"
    case tfal = "T-fal"
    case deLonghi = "De'Longhi"
    case philips = "Philips"
    case russellHobbs = "Russell Hobbs"
    case nespresso = "Nespresso"
    case keurig = "Keurig"
    case mrCoffee = "Mr. Coffee"
    case krups = "Krups"
    case dash = "Dash"
    case vitamix = "Vitamix"
    case blendtec = "Blendtec"
    case nutriBullet = "Nutribullet"
    case instantPot = "Instant Pot"
    case crockPot = "Crock-Pot"
    case zojirushi = "Zojirushi"
    case tigerCorporation = "Tiger Corporation"
    case blackstone = "Blackstone"
    case weber = "Weber"
    case charBroil = "Char-Broil"
    case traeger = "Traeger"
    case napoleon = "Napoleon"
    case broilKing = "Broil King"
    case coleman = "Coleman"
    case campChef = "Camp Chef"
    case lodge = "Lodge"
    case leCreuset = "Le Creuset"
    case calphalon = "Calphalon"
    case allClad = "All-Clad"
    case rachaelRay = "Rachael Ray"
    case pyrex = "Pyrex"
    case anchorHocking = "Anchor Hocking"
    case rubbermaid = "Rubbermaid"
    case oxo = "Oxo"
    case simplehuman = "Simplehuman"
    case generic = "Generic Brand"

    var formattedRawValue: String {
        self.rawValue
    }
}

// Enumeration representing appliance symbols
enum ApplianceSymbol: String, ApplianceEnumProtocol {
    static var title = "Appliance Symbol"
    case oven
    case refrigerator
    case dishwasher
    case flipphone
    case candybarphone
    case webCamera = "web.camera"
    case videoDoorbell = "video.doorbell"
    case entryLeverKeypad = "entry.lever.keypad"
    case dehumidifier
    case airPurifier = "air.purifier"
    case humidifier
    case verticalHeater = "heater.vertical"
    case hifiReceiver = "hifireceiver"
    case videoProjector = "videoprojector"
    case wifiRouter = "wifi.router"
    case washer
    case dryer
    case stove
    case cooktop
    case microwave
    case radio
    case headphones
    case guitars
    case arcadeStickConsole = "arcade.stick.console"
    case gameController = "gamecontroller"
    case scanner
    case printer
    case faxMachine = "faxmachine"
    case display
    case pc
    case xserve
    case laptopComputer = "laptopcomputer"
    case macStudio = "macstudio"
    case macMini = "macmini"
    case computerMouse = "computermouse"
    case hifiSpeaker = "hifispeaker"
    case car
    case amplifier
    case wrenchAndScrewdriverFill = "wrench.and.screwdriver.fill"
    case powerOutletTypeIFill = "poweroutlet.type.i.fill"

    // Computed property to return the symbol as an image
    var image: Image {
        Image(systemName: rawValue)
    }

    var formattedRawValue: String {
        "Adherance to protocol ApplianceEnumProtocol not yet implemented"
    }
}

extension ApplianceType {
    var symbol: ApplianceSymbol {
        switch self {
        case .refrigerator:
            return .refrigerator
        case .oven:
            return .oven
        case .microwave:
            return .microwave
        case .dishwasher:
            return .dishwasher
        case .blender:
            return .wrenchAndScrewdriverFill
        case .toaster:
            return .stove
        case .coffeeMaker:
            return .pc
        case .foodProcessor:
            return .display
        case .mixer:
            return .hifiSpeaker
        case .electricKettle:
            return .powerOutletTypeIFill
        case .washingMachine:
            return .washer
        case .dryer:
            return .dryer
        case .iron:
            return .wrenchAndScrewdriverFill
        case .steamPress:
            return .powerOutletTypeIFill
        case .vacuumCleaner:
            return .wrenchAndScrewdriverFill
        case .steamCleaner:
            return .videoProjector
        case .carpetCleaner:
            return .wrenchAndScrewdriverFill
        case .floorPolisher:
            return .wrenchAndScrewdriverFill
        case .airConditioner:
            return .airPurifier
        case .heater:
            return .verticalHeater
        case .humidifier:
            return .humidifier
        case .dehumidifier:
            return .dehumidifier
        case .fan:
            return .wrenchAndScrewdriverFill
        case .airPurifier:
            return .airPurifier
        case .hairDryer:
            return .wrenchAndScrewdriverFill
        case .electricShaver:
            return .wrenchAndScrewdriverFill
        case .electricToothbrush:
            return .wrenchAndScrewdriverFill
        case .hairStraightener:
            return .wrenchAndScrewdriverFill
        case .curlingIron:
            return .wrenchAndScrewdriverFill
        case .television:
            return .display
        case .homeTheaterSystem:
            return .hifiSpeaker
        case .soundbar:
            return .hifiSpeaker
        case .dvdPlayer:
            return .wrenchAndScrewdriverFill
        case .gamingConsole:
            return .gameController
        case .computer:
            return .pc
        case .printer:
            return .printer
        case .scanner:
            return .scanner
        case .faxMachine:
            return .faxMachine
        case .garbageDisposal:
            return .wrenchAndScrewdriverFill
        case .waterHeater:
            return .powerOutletTypeIFill
        case .sewingMachine:
            return .wrenchAndScrewdriverFill
        case .electricFireplace:
            return .powerOutletTypeIFill
        case .electricBlanket:
            return .wrenchAndScrewdriverFill
        case .generic:
            return .wrenchAndScrewdriverFill
        }
    }
}
