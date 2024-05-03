//
//  ApplianceSymbol.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation
import SwiftUI

// Enumeration representing appliance symbols
enum DefaultSymbols: String, ApplianceEnumProtocol {
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
