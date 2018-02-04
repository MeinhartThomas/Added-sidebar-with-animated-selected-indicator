//
//  CellCreater.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 15.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit

class CellDescription{
  
}

//MARK: - CellDesription Subclasses

class CellDescriptionWorkButton: CellDescription {
    var work: Work
    var labelText: String
    var iconName: String

    init(labelText: String, work: Work, iconName: String) {
        self.work = work
        self.labelText = labelText
        self.iconName = iconName
    }
}

class CellDescriptionMaterialButton: CellDescription {
    var material: Material
    var labelText: String
    
    init(labelText: String, material: Material) {
        self.material = material
        self.labelText = labelText
    }
}

class CellDescriptionConditionButton: CellDescription {
    var condition: Condition
    var labelText: String
    var descriptionText: String
    var iconName: String

    
    init(labelText: String, descriptionText: String, condition: Condition, iconName: String) {
        self.condition = condition
        self.labelText = labelText
        self.descriptionText = descriptionText
        self.iconName = iconName
    }
}

class CellDescriptionWorkingStepButton: CellDescription {
    var workingStep: WorkingStep
    var labelText: String
    
    init(labelText: String, workingStep: WorkingStep) {
        self.workingStep = workingStep
        self.labelText = labelText
    }
}

class CellDescriptionTextField: CellDescription {
  
}

class CellDescriptionDescriptionLabel: CellDescription {
    var labelText: String

    init(labelText: String) {
        self.labelText = labelText
    }
}

class CellDescriptionCalculateButton: CellDescription {
    var labelText: String
    
    init(labelText: String) {
        self.labelText = labelText
    }
}

class CellDescriptionToolButton: CellDescription {
    var labelText: String
    var tool: Tool
    
    init(labelText: String, tool: Tool) {
        self.labelText = labelText
        self.tool = tool
    }
}
    
class CellDescriptionResult: CellDescription {
    var diameterLabel: String
    var cuttingSpeedLabel: String
    var rotationSpeedLabel: String
    var lubricationLabel: String
    
    init(diameterLabel: String, cuttingSpeedLabel: String, rotationSpeedLabel: String, lubricationLabel: String) {
        self.diameterLabel = diameterLabel
        self.cuttingSpeedLabel = cuttingSpeedLabel
        self.rotationSpeedLabel = rotationSpeedLabel
        self.lubricationLabel = lubricationLabel
    }
}

class CellDescriptionRestartButton: CellDescription {
    
}



