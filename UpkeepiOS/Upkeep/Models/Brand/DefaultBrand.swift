//
//  ApplianceBrand.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation

enum DefaultBrand: String, BrandProtocol, CaseIterable {
    case samsung = "Samsung"
    case lg = "LG"
    case whirlpool = "Whirlpool"
    case geAppliances = "GE Appliances"
    case bosch = "Bosch"
    case electrolux = "Electrolux"
    case frigidaire = "Frigidaire"
    case maytag = "Maytag"
    case kitchenaid = "Kitchenaid"
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

    var name: String {
        self.rawValue
    }

    var id: String {
        self.rawValue
    }
}

extension DefaultBrand: CodingKey {
    var stringValue: String {
        return rawValue.camelCase()
    }

    init?(stringValue: String) {
        // This initializer is not needed since we only encode to JSON
        return nil
    }

    var intValue: Int? {
        return nil
    }

    init?(intValue: Int) {
        return nil
    }
}
