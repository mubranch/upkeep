//
//  ApplianceType.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation

enum DefaultCategory: String, CategoryProtocol, CaseIterable {
    // Kitchen Appliances
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
    case slowCooker = "Slow Cooker"
    case airFryer = "Air Fryer"
    case iceMaker = "Ice Maker"
    case inductionCooktop = "Induction Cooktop"
    case espressoMachine = "Espresso Machine"
    case convectionOven = "Convection Oven"
    case juicer
    case deepFryer = "Deep Fryer"
    case riceCooker = "Rice Cooker"
    case breadMaker = "Bread Maker"
    case rotisserie
    case foodDehydrator = "Food Dehydrator"

    // Cleaning and Maintenance
    case vacuumCleaner = "Vacuum Cleaner"
    case steamCleaner = "Steam Cleaner"
    case carpetCleaner = "Carpet Cleaner"
    case floorPolisher = "Floor Polisher"
    case electricMop = "Electric Mop"
    case roboticPoolCleaner = "Robotic Pool Cleaner"
    case ultrasonicCleaner = "Ultrasonic Cleaner"

    // Heating and Cooling
    case airConditioner = "Air Conditioner"
    case heater
    case humidifier
    case dehumidifier
    case fan
    case portableHeater = "Portable Heater"
    case airPurifier = "Air Purifier"
    case portableAC = "Portable AC"
    case windowAirConditioner = "Window Air Conditioner"

    // Laundry and Ironing
    case washingMachine = "Washing Machine"
    case dryer
    case iron
    case steamPress = "Steam Press"

    // Personal Care
    case hairDryer = "Hair Dryer"
    case electricShaver = "Electric Shaver"
    case electricToothbrush = "Electric Toothbrush"
    case hairStraightener = "Hair Straightener"
    case curlingIron = "Curling Iron"

    // Home Entertainment
    case television
    case homeTheaterSystem = "Home Theater System"
    case soundbar
    case dvdPlayer = "DVD Player"
    case gamingConsole = "Gaming Console"

    // Office Electronics
    case computer
    case printer
    case scanner
    case faxMachine

    // Utility and Miscellaneous
    case garbageDisposal = "Garbage Disposal"
    case waterHeater = "Water Heater"
    case sewingMachine = "Sewing Machine"
    case electricFireplace = "Electric Fireplace"
    case electricBlanket = "Electric Blanket"
    case waterSoftener = "Water Softener"
    case waterPurifier = "Water Purifier"
    case powerGenerator = "Power Generator"

    // Smart Home Devices
    case smartSpeaker = "Smart Speaker"
    case securityCamera = "Security Camera"
    case thermostat
    case doorbellCamera = "Doorbell Camera"
    case smartLight = "Smart Light"
    case smartLock = "Smart Lock"
    case smartBlinds = "Smart Blinds"
    case smartRefrigerator = "Smart Refrigerator"
    case smartThermostat = "Smart Thermostat"
    case homeAutomationHub = "Home Automation Hub"

    // Outdoor and Leisure
    case outdoorGrill = "Outdoor Grill"
    case poolFilter = "Pool Filter"
    case poolHeater = "Pool Heater"
    case hotTub = "Hot Tub"
    case sauna

    // Safety and Security
    case smokeDetector = "Smoke Detector"
    case carbonMonoxideDetector = "Carbon Monoxide Detector"
    case radonDetector = "Radon Detector"
    case securitySystem = "Security System"
    case drivewayAlarm = "Driveway Alarm"

    // Advanced Technology
    case projector
    case networkRouter
    case signalRepeater = "Signal Repeater"
    case portableProjector = "Portable Projector"
    case videoProjector = "Video Projector"
    case satelliteReceiver = "Satellite Receiver"
    case eBookReader = "eBook Reader"
    case documentCamera = "Document Camera"
    case digitalWhiteboard = "Digital Whiteboard"
    case languageTranslatorDevice = "Language Translator Device"
    case fitnessTracker = "Fitness Tracker"
    case sleepTracker = "Sleep Tracker"
    case vrHeadset = "VR Headset"
    case smartGlasses = "Smart Glasses"

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
        if let symbol = DefaultSymbols(rawValue: self.rawValue) {
            return symbol
        } else {
            return DefaultSymbols.generic
        }
    }
}
