//
//  Calculation.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 15.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation

class Calculation{
    
    var work: Work?
    var tool: Tool?
    var condition: Condition?
    var workingStep: WorkingStep?
    var material: Material?
    var diameter: Double?
    
    var rotationSpeed: Double?
    var forwardSpeed: Double?
    
    //MARK: - rotation speed calculation methods
    
    func getRotationSpeedAndForwardSpeed(){
        let values = CuttingAndForwardSpeed.getValuesFor(work: work!, workingStep: workingStep, tool: tool, material: material!)
        forwardSpeed = values.forwardSpeed
        rotationSpeed = calculateRotationalSpeed(cuttingSpeed: values.cuttingSpeed!)
    }
    
    private func calculateRotationalSpeed(cuttingSpeed: Int) -> Double {
        return Double(1000 * cuttingSpeed)/(self.diameter! * Double.pi)
    }
}
