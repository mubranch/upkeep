//
//  ApplianceBrand.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation

enum DefaultBrands: String, BrandProtocol, CaseIterable {
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
    case emerson = "Emerson"
    case rinnai = "Rinnai"
    case stiebelEltron = "Stiebel Eltron"
    case noritz = "Noritz"
    case eemax = "Eemax"
    case rheem = "Rheem"
    case bradfordWhite = "Bradford White"
    case aOmith = "A.O. Smith"
    case takagi = "Takagi"
    case eccotemp = "Eccotemp"
    case navien = "Navien"
    case boschThermotechnology = "Bosch Thermotechnology"
    case midea = "Midea"
    case lgElectronics = "LG Electronics"
    case sanyo = "Sanyo"
    case amanaHeatingCooling = "Amana Heating & Cooling"
    case haierAmerica = "Haier America"
    case fujitsu = "Fujitsu"
    case daikin = "Daikin"
    case carrier = "Carrier"
    case trane = "Trane"
    case lennox = "Lennox"
    case goodman = "Goodman"
    case york = "York"
    case bryant = "Bryant"
    case payne = "Payne"
    case americanStandard = "American Standard"
    case ruud = "Ruud"
    case heil = "Heil"
    case armstrongAir = "Armstrong Air"
    case luxaire = "Luxaire"
    case tempstar = "Tempstar"
    case ducane = "Ducane"
    case comfortmaker = "Comfortmaker"
    case dewalt = "DeWalt"
    case milwaukee = "Milwaukee"
    case makita = "Makita"
    case ridgid = "Ridgid"
    case ryobi = "Ryobi"
    case porterCable = "Porter-Cable"
    case craftsman = "Craftsman"
    case skil = "Skil"
    case metabo = "Metabo"
    case festool = "Festool"
    case hilti = "Hilti"
    case stanley = "Stanley"
    case fein = "Fein"
    case wagner = "Wagner"
    case kobalt = "Kobalt"
    case bostitch = "Bostitch"
    case jet = "Jet"
    case powermatic = "Powermatic"
    case grizzly = "Grizzly"
    case delta = "Delta"
    case wen = "WEN"
    case shopVac = "Shop-Vac"
    case dremel = "Dremel"
    case rockwell = "Rockwell"
    case metaboHpt = "Metabo HPT"
    case hitachiKoki = "Hitachi Koki"
    case astroPneumatic = "Astro Pneumatic"
    case centurion = "Centurion"
    case oemTools = "OEM Tools"
    case sunex = "Sunex"
    case acDelco = "ACDelco"
    case powryte = "PowRyte"
    case vonhaus = "VonHaus"
    case trumax = "Trumax"
    case schumacher = "Schumacher"
    case wagan = "Wagan"
    case cloreAutomotive = "Clore Automotive"
    case batteryTender = "Battery Tender"
    case nilfisk = "Nilfisk"
    case karcher = "Karcher"
    case arBlueClean = "AR Blue Clean"
    case sunJoe = "Sun Joe"
    case generac = "Generac"
    case powerstroke = "PowerStroke"
    case powercare = "PowerCare"
    case briggsStratton = "Briggs & Stratton"
    case stihl = "STIHL"
    case echo = "Echo"
    case husqvarna = "Husqvarna"
    case poulanPro = "Poulan Pro"
    case toro = "Toro"
    case ariens = "Ariens"
    case troyBilt = "Troy-Bilt"
    case yardMachines = "Yard Machines"
    case cubCadet = "Cub Cadet"
    case snapper = "Snapper"
    case johnDeere = "John Deere"
    case greenworks = "Greenworks"
    case ego = "EGO"
    case earthwise = "Earthwise"
    case powerSmart = "PowerSmart"
    case worx = "WORX"
    case snowJoe = "Snow Joe"
    case remington = "Remington"

    var name: String {
        self.rawValue
    }

    var id: String {
        self.rawValue
    }
}

extension DefaultBrands: CodingKey {
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
