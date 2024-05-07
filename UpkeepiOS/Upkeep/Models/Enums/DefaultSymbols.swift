//
//  ApplianceSymbol.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation
import SwiftUI

// Enumeration representing appliance symbols
enum DefaultSymbols: String, CaseIterable, Codable {
    case refrigerator
    case oven = "stove"
    case microwave
    case dishwasher
    case blender
    case toaster
    case coffeeMaker = "cup.and.saucer"
    case foodProcessor = "foodprocessor"
    case mixer = "mixer.horizontal.2"
    case electricKettle = "kettle"
    case slowCooker = "slowcooker"
    case airFryer = "airfryer"
    case iceMaker = "icemaker"
    case inductionCooktop = "rectangle.split.3x3"
    case espressoMachine = "espressomachine"
    case juicer = "drop.fill"
    case deepFryer = "frying.pan"
    case riceCooker = "ricecooker"
    case breadMaker = "loaf.bread"
    case rotisserie = "flame"
    case foodDehydrator = "wind"
    case vacuumCleaner = "vacuum"
    case steamCleaner = "cloud.fill"
    case carpetCleaner = "rectangle.and.pencil.and.ellipsis"
    case floorPolisher = "circle.grid.cross.down.fill"
    case airConditioner = "airconditioner"
    case heater = "heat.waves"
    case humidifier = "drop.circle"
    case dehumidifier = "drop.circle.fill"
    case fan = "fanblades"
    case airPurifier = "airpurifier"
    case portableHeater = "fanblades.fill"
    case windowAirConditioner = "rectangle.fill.on.rectangle.fill"
    case washingMachine = "washingmachine"
    case dryer
    case iron
    case steamPress = "rectangle.compress.vertical"
    case hairDryer = "hairdryer"
    case electricShaver = "razor"
    case electricToothbrush = "toothbrush"
    case hairStraightener = "comb.fill"
    case curlingIron = "curlingiron"
    case television = "tv"
    case homeTheaterSystem = "theatermasks.fill"
    case soundbar
    case dvdPlayer = "dvd.fill"
    case gamingConsole = "gamecontroller"
    case computer = "desktopcomputer"
    case printer
    case scanner
    case faxMachine = "faxmachine"
    case garbageDisposal = "trash.circle"
    case waterHeater = "drop.triangle"
    case sewingMachine = "sewingneedle"
    case electricFireplace = "fireplace"
    case electricBlanket = "bed.double"
    case waterPurifier = "waterbottle"
    case powerGenerator = "sparkles"
    case smartSpeaker = "speaker.wave.3"
    case securityCamera = "video.circle"
    case thermostat = "thermometer.sun"
    case doorbellCamera = "video.bubble.left"
    case smartLight = "lightbulb"
    case smartLock = "lock"
    case smartBlinds = "rectangle.3.offgrid.bubble.left"
    case smartThermostat = "thermometer"
    case homeAutomationHub = "network"
    case sauna = "rectangle.fill.on.rectangle.angled.fill"
    case smokeDetector = "smoke.fill"
    case carbonMonoxideDetector = "waveform.path.ecg.rectangle.fill"
    case radonDetector = "dot.radiowaves.left.and.right.circle"
    case securitySystem = "lock.shield"
    case drivewayAlarm = "sensor.tag.radiowaves.forward.fill"
    case weatherStation = "cloud.sun.fill"
    case projector = "projector.fill"
    case networkRouter = "network.badge.shield.half.filled"
    case signalRepeater = "antenna.radiowaves.left.and.right"
    case portableProjector = "movieclapper"
    case videoProjector = "video.fill"
    case satelliteReceiver = "satellite.fill"
    case eBookReader = "book"
    case documentCamera = "camera.doc"
    case digitalWhiteboard = "rectangle.portrait.and.arrow.right"
    case languageTranslatorDevice = "globe.americas.fill"
    case fitnessTracker = "figure.walk"
    case sleepTracker = "powersleep"
    case VRHeadset = "vrheadset"
    case smartGlasses = "glasses"
    case generic = "wrench.and.screwdriver"

    var image: Image {
        Image(systemName: rawValue)
    }

    var formattedRawValue: String {
        "Adherance to protocol ApplianceEnumProtocol not yet implemented"
    }
}
