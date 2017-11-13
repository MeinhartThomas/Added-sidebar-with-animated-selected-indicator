//
//  RevCalc.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 09.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation

//MARK: - Enums


enum CellType: String {
    case buttonWhiteBig, buttonWhiteSmall, buttonBlackSmall, descriptionLabel
}

enum Material: Int {
    case steelUnder500 = 1
    case steelOver500 = 2
    case brassBronze = 3
    case aluminium = 4
    case plastic = 5
}

enum Condition: Int {
    case optimal = 1
    case normal = 2
    case bad = 3
}

enum Work: Int {
    case drilling = 1
    case lathing = 2
    case milling = 3
}

enum WorkingStep: Int {
    case schlichten = 1
    case schruppen = 2
    case abstechen = 3
    case einstechen = 4
}

enum Tool: Int {
    case HSS = 1
    case HM = 2
}

struct Cell {
    init(celltype: CellType, labeltext: String?) {
        self.celltype = celltype
        self.labeltext = labeltext
    }
    var celltype: CellType
    var labeltext: String?
}

class CalculatorLogic {
    
//    var workingStep: WorkingStep?{
//        didSet{
//            if workingStep == WorkingStep.drilling {
//                tool = Tool.HSS.rawValue
//            }
//        }
//    }
    
//    var tool: Int?
//    var condition: Int?
//    var material: Int?
//    var diameter: Double?
    
    var drillingData: [[String]] = []
    var cells: [Cell] = []
    

    init() {
        drillingData = readDataFromCSV("drillingdata.csv")
        cells = [Cell(celltype: CellType.descriptionLabel, labeltext: "Wähle den Arbeitsschritt") ,Cell(celltype: CellType.buttonWhiteBig, labeltext: "Bohren"), Cell(celltype: CellType.buttonWhiteBig, labeltext: "Drehen"), Cell(celltype: CellType.buttonWhiteBig, labeltext: "Fräsen")]
    }
    
    //MARK: - rotation speed calculation methods
    
    func calculateRotationSpeed(_ workingStep: Work){
        
    }
    
    func calculateDrillingRotationalSpeed(condition: Condition, material: Material, diameter: Double) -> Double {
        let cuttingSpeed = getCuttingSpeed(from: material)
        
        return Double(1000 * cuttingSpeed)/(diameter * Double.pi)
    }
    
    func getCuttingSpeed(from material: Material) -> Int{
        return Int(drillingData[1][material.rawValue])!
    }
    
    //MARK: - read from CSV methods
    
    func readDataFromCSV(_ filename: String) -> [[String]] {
        var text = ""
        
        let path = Bundle.main.path(forResource: "drillingdata", ofType: "csv")
        
        do {
            text = try String(contentsOfFile: path!, encoding: .utf8)
        }
        catch {
            print("caught: \(error)")
        }
        
        text = cleanRows(file: text)
       
    
        return text.components(separatedBy: "\n").map{ $0.components(separatedBy:";") }
    }
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
}
