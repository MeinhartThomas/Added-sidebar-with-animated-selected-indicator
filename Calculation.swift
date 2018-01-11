//
//  Calculation.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 15.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation

class Calculation: NSObject, NSCoding{

    var work: Work?
    var tool: Tool?
    var condition: Condition?
    var workingStep: WorkingStep?
    var material: Material?
    var diameter: Double?
    var cuttingSpeed: Int?
    var rotationSpeed: Int?
    var forwardSpeed: Double?
    var name: String?
    var notes: String?
    
    override init() {
        
    }
    
    
    //MARK: - rotation speed calculation methods
    
    func getRotationSpeedAndForwardSpeed(){
        let values = CuttingAndForwardSpeed.getValuesFor(work: work!, workingStep: workingStep, tool: tool, material: material!)
        forwardSpeed = values.forwardSpeed
        cuttingSpeed = values.cuttingSpeed
        rotationSpeed = calculateRotationalSpeed(cuttingSpeed: values.cuttingSpeed!)
    }
    
    private func calculateRotationalSpeed(cuttingSpeed: Int) -> Int {
        return Int(Double(1000 * cuttingSpeed)/(self.diameter! * Double.pi))
    }
    
    
    func encode(with aCoder: NSCoder) {

        aCoder.encode(work, forKey: "work")
        aCoder.encode(tool, forKey: "tool")
        aCoder.encode(condition, forKey: "condition")
        aCoder.encode(workingStep, forKey: "workingStep")
        aCoder.encode(material, forKey: "material")
        aCoder.encode(diameter, forKey: "diameter")
        aCoder.encode(cuttingSpeed, forKey: "cuttingSpeed")
        aCoder.encode(rotationSpeed, forKey: "rotationSpeed")
        aCoder.encode(forwardSpeed, forKey: "forwardSpeed")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(notes, forKey: "notes")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        work = aDecoder.decodeObject(forKey: "work") as? Work
        tool = aDecoder.decodeObject(forKey: "tool") as? Tool
        condition = aDecoder.decodeObject(forKey: "condition") as? Condition
        workingStep = aDecoder.decodeObject(forKey: "workingStep") as? WorkingStep
        material = aDecoder.decodeObject(forKey: "material") as? Material
        diameter = aDecoder.decodeObject(forKey: "diameter") as? Double
        cuttingSpeed = aDecoder.decodeObject(forKey: "cuttingSpeed") as? Int
        rotationSpeed = aDecoder.decodeObject(forKey: "rotationSpeed") as? Int
        forwardSpeed = aDecoder.decodeObject(forKey: "forwardSpeed") as? Double
        name = aDecoder.decodeObject(forKey: "name") as? String
        notes = aDecoder.decodeObject(forKey: "notes") as? String
    }
    
    
}
