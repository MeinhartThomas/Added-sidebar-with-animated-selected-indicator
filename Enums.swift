//
//  Enums.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 14.12.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation


enum CellType: String {
    case buttonWhiteBig, buttonWhiteSmall, buttonBlackSmall, descriptionLabel, textFieldWhite, separator
}

enum Material: String, Codable {
    case steelUnder500 = "Stahl < 500"
    case steelOver500 = "Stahl > 500"
    case brassOrBronze = "Messing / Bronze"
    case aluminium = "Aluminium"
    case plastic = "Kunststoff"
}

enum Condition: String, Codable {
    case optimal = "Optimal"
    case normal = "Normal"
    case bad = "Schlecht"
}

enum Work: String, Codable {
    case drilling = "Bohren"
    case lathing = "Drehen"
    case milling = "Fräsen"
    
    static func getIconName(work: Work) -> String{
        switch work {
        case .drilling:
            return "drillingIcon"
        case .lathing:
            return "lathingIcon"
        case .milling:
            return "millingIcon"
            
        }
    }
}

enum WorkingStep: String, Codable {
    case schlichten = "Schlichten"
    case schruppen = "Schruppen"
    case abstechen = "Abstechen"
    case einstechen = "Einstechen"
}

enum Tool: String, Codable {
    case HSS = "HSS"
    case HM = "HM"
}

enum TextFieldType {
    case diameter, forwardSpeed
}
