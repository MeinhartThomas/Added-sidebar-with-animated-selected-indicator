//
//  RevCalc.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 09.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Enums


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


class CalculatorLogic {
    
    var currentCalculation = Calculation()
    var drillingData: [[String]] = []
    var cells: [CellDescription] = []
    var sidebarItems: [SideBarItemDescription] = []
    

    init() {        
        setWorkSelectionScreen()
    }
    
    //MARK: - ScreenSetters
    
    func setCellsForNextScreen(){
        switch currentCalculation.work! {
        case Work.drilling:
            if currentCalculation.condition == nil {
                setConditionSelectionScreen()
            } else if currentCalculation.material == nil {
                setMaterialSelectionScreen()
            } else if currentCalculation.diameter == nil {
                setDiameterInputScreen()
            } else {
                setResultScreen()
            }
            break
        case Work.lathing:
            if currentCalculation.condition == nil {
                setConditionSelectionScreen()
            } else if currentCalculation.workingStep == nil {
                setWorkingStepSelectionScreen()
            } else if currentCalculation.tool == nil && (currentCalculation.workingStep == WorkingStep.schlichten || currentCalculation.workingStep == WorkingStep.schruppen) {
                setToolSelectionScreen()
            } else if currentCalculation.material == nil {
                setMaterialSelectionScreen()
            } else if currentCalculation.diameter == nil {
                setDiameterInputScreen()
            } else {
                setResultScreen()
            }
            break
        case Work.milling:
            if currentCalculation.condition == nil {
                setConditionSelectionScreen()
            } else if currentCalculation.workingStep == nil {
                setWorkingStepSelectionScreen()
            } else if currentCalculation.tool == nil {
                setToolSelectionScreen()
            } else if currentCalculation.material == nil {
                setMaterialSelectionScreen()
            } else if currentCalculation.diameter == nil {
                setDiameterInputScreen()
            } else {
                setResultScreen()
            }
            break
        }
    }

    
    private func setWorkSelectionScreen() {
        cells = [CellDescriptionDescriptionLabel(labelText: "Wähle den Arbeitsschritt"),
                 CellDescriptionWorkButton(labelText: "Bohren", work: Work.drilling, iconName: "drillingIconBlack"),
                 CellDescriptionWorkButton(labelText: "Drehen", work: Work.lathing, iconName: "lathingIconBlack"),
                 CellDescriptionWorkButton(labelText: "Fräsen", work: Work.milling, iconName: "millingIconBlack")]
        sidebarItems.append(SideBarItemDescription(label: "Arbeitsschritt", icon: "drillingIcon"))
    }
    
    private func setConditionSelectionScreen() {
        cells = [CellDescriptionDescriptionLabel(labelText: "Wähle die Bedingung"),
                 CellDescriptionConditionButton(labelText: "Optimal", descriptionText: "CNC-Maschine \noptimale Schmierung", condition: Condition.optimal),
                 CellDescriptionConditionButton(labelText: "Normal", descriptionText: "Werkstätte \nausreichende Schmierung", condition: Condition.normal),
                 CellDescriptionConditionButton(labelText: "Schlecht", descriptionText: "Baustelle \nunzureichende Schmierung", condition: Condition.bad)]
        sidebarItems[0] = SideBarItemDescription(label: currentCalculation.work!.rawValue, icon: Work.getIconName(work: currentCalculation.work!))
        sidebarItems.append(SideBarItemDescription(label: "Bedingung", icon: "conditionIcon"))
    }
    
    private func setToolSelectionScreen() {
        cells = [CellDescriptionDescriptionLabel(labelText: "Wähle das Werkzeug"),
                 CellDescriptionToolButton(labelText: "HSS", tool: Tool.HSS),
                 CellDescriptionToolButton(labelText: "HM", tool: Tool.HM)]
        sidebarItems[2] = SideBarItemDescription(label: currentCalculation.workingStep!.rawValue, icon: "workingStepIcon")
        sidebarItems.append(SideBarItemDescription(label: "Werkzeug", icon: "toolIcon"))
    }
    
    private func setMaterialSelectionScreen(){
        switch currentCalculation.work! {
            case .drilling:
                cells = [CellDescriptionDescriptionLabel(labelText: "Wähle das Material"),
                         CellDescriptionMaterialButton(labelText: "Stahl bis 500N/mm\u{00B2}", material: Material.steelUnder500),
                         CellDescriptionMaterialButton(labelText: "Stahl über 500N/mm\u{00B2}", material: Material.steelOver500),
                         CellDescriptionMaterialButton(labelText: "Aluminium", material: Material.aluminium),
                         CellDescriptionMaterialButton(labelText: "Messing / Bronze", material: Material.brassOrBronze),
                         CellDescriptionMaterialButton(labelText: "Kunststoff", material: Material.plastic)]
                sidebarItems[1] = SideBarItemDescription(label: currentCalculation.condition!.rawValue, icon: "conditionIcon")
                sidebarItems.append(SideBarItemDescription(label: "Material", icon: "materialIcon"))
            case .lathing:
                switch currentCalculation.workingStep! {
                    case .schruppen, .schlichten:
                        switch currentCalculation.tool! {
                            case .HSS:
                                cells = [CellDescriptionDescriptionLabel(labelText: "Wähle das Material"),
                                         CellDescriptionMaterialButton(labelText: "Stahl bis 500N/mm\u{00B2}", material: Material.steelUnder500),
                                         CellDescriptionMaterialButton(labelText: "Stahl über 500N/mm\u{00B2}", material: Material.steelOver500),
                                         CellDescriptionMaterialButton(labelText: "Aluminium", material: Material.aluminium),
                                         CellDescriptionMaterialButton(labelText: "Messing / Bronze", material: Material.brassOrBronze),
                                         CellDescriptionMaterialButton(labelText: "Kunststoff", material: Material.plastic)]
                                sidebarItems[3] = SideBarItemDescription(label: currentCalculation.tool!.rawValue, icon: "toolIcon")
                                sidebarItems.append(SideBarItemDescription(label: "Material", icon: "materialIcon"))
                            case .HM:
                                cells = [CellDescriptionDescriptionLabel(labelText: "Wähle das Material"),
                                         CellDescriptionMaterialButton(labelText: "Stahl bis 500N/mm\u{00B2}", material: Material.steelUnder500),
                                         CellDescriptionMaterialButton(labelText: "Stahl über 500N/mm\u{00B2}", material: Material.steelOver500),
                                         CellDescriptionMaterialButton(labelText: "Aluminium", material: Material.aluminium),
                                         CellDescriptionMaterialButton(labelText: "Messing / Bronze", material: Material.brassOrBronze)]
                                sidebarItems[3] = SideBarItemDescription(label: currentCalculation.tool!.rawValue, icon: "toolIcon")
                                sidebarItems.append(SideBarItemDescription(label: "Material", icon: "materialIcon"))
                    }
                    case .abstechen:
                        cells = [CellDescriptionDescriptionLabel(labelText: "Wähle das Material"),
                                 CellDescriptionMaterialButton(labelText: "Stahl bis 500N/mm\u{00B2}", material: Material.steelUnder500),
                                 CellDescriptionMaterialButton(labelText: "Stahl über 500N/mm\u{00B2}", material: Material.steelOver500),
                                 CellDescriptionMaterialButton(labelText: "Aluminium", material: Material.aluminium),
                                 CellDescriptionMaterialButton(labelText: "Messing / Bronze", material: Material.brassOrBronze),
                                 CellDescriptionMaterialButton(labelText: "Kunststoff", material: Material.plastic)]
                        sidebarItems[2] = SideBarItemDescription(label: currentCalculation.workingStep!.rawValue, icon: "workingStepIcon")
                        sidebarItems.append(SideBarItemDescription(label: "Material", icon: "materialIcon"))
                    case .einstechen:
                        cells = [CellDescriptionDescriptionLabel(labelText: "Wähle das Material"),
                                 CellDescriptionMaterialButton(labelText: "Stahl bis 500N/mm\u{00B2}", material: Material.steelUnder500),
                                 CellDescriptionMaterialButton(labelText: "Stahl über 500N/mm\u{00B2}", material: Material.steelOver500)]
                        sidebarItems[2] = SideBarItemDescription(label: currentCalculation.workingStep!.rawValue, icon: "workingStepIcon")
                        sidebarItems.append(SideBarItemDescription(label: "Material", icon: "materialIcon"))
                    
            }
            case .milling:
                switch currentCalculation.workingStep! {
                case .schruppen, .schlichten:
                    switch currentCalculation.tool! {
                    case .HSS:
                        cells = [CellDescriptionDescriptionLabel(labelText: "Wähle das Material"),
                                 CellDescriptionMaterialButton(labelText: "Stahl bis 500N/mm\u{00B2}", material: Material.steelUnder500),
                                 CellDescriptionMaterialButton(labelText: "Stahl über 500N/mm\u{00B2}", material: Material.steelOver500),
                                 CellDescriptionMaterialButton(labelText: "Aluminium", material: Material.aluminium),
                                 CellDescriptionMaterialButton(labelText: "Messing / Bronze", material: Material.brassOrBronze),
                                 CellDescriptionMaterialButton(labelText: "Kunststoff", material: Material.plastic)]
                        sidebarItems[3] = SideBarItemDescription(label: currentCalculation.tool!.rawValue, icon: "toolIcon")
                        sidebarItems.append(SideBarItemDescription(label: "Material", icon: "materialIcon"))
                    case .HM:
                        cells = [CellDescriptionDescriptionLabel(labelText: "Wähle das Material"),
                                 CellDescriptionMaterialButton(labelText: "Stahl bis 500N/mm\u{00B2}", material: Material.steelUnder500),
                                 CellDescriptionMaterialButton(labelText: "Stahl über 500N/mm\u{00B2}", material: Material.steelOver500),
                                 CellDescriptionMaterialButton(labelText: "Aluminium", material: Material.aluminium),
                                 CellDescriptionMaterialButton(labelText: "Messing / Bronze", material: Material.brassOrBronze)]
                        sidebarItems[3] = SideBarItemDescription(label: currentCalculation.tool!.rawValue, icon: "toolIcon")
                        sidebarItems.append(SideBarItemDescription(label: "Material", icon: "materialIcon"))
                    }
                case .abstechen, .einstechen:
                    break
            }
        }
    }
    
    private func setWorkingStepSelectionScreen(){
        switch currentCalculation.work! {
            case Work.drilling:
                break
        case Work.lathing:
            cells = [CellDescriptionDescriptionLabel(labelText: "Wähle den Arbeitsschritt"),
                     CellDescriptionWorkingStepButton(labelText: "Schlichten", workingStep: WorkingStep.schlichten),
                     CellDescriptionWorkingStepButton(labelText: "Schruppen", workingStep: WorkingStep.schruppen),
                     CellDescriptionWorkingStepButton(labelText: "Abstechen", workingStep: WorkingStep.abstechen),
                     CellDescriptionWorkingStepButton(labelText: "Einstechen", workingStep: WorkingStep.einstechen)]
            sidebarItems[1] = SideBarItemDescription(label: currentCalculation.condition!.rawValue, icon: "conditionIcon")
            sidebarItems.append(SideBarItemDescription(label: "Arbeitsschritt", icon: "workingStepIcon"))
        case Work.milling:
            cells = [CellDescriptionDescriptionLabel(labelText: "Wähle den Arbeitsschritt"),
                     CellDescriptionWorkingStepButton(labelText: "Schlichten", workingStep: WorkingStep.schlichten),
                     CellDescriptionWorkingStepButton(labelText: "Schruppen", workingStep: WorkingStep.schruppen)]
            sidebarItems[1] = SideBarItemDescription(label: currentCalculation.condition!.rawValue, icon: "conditionIcon")
            sidebarItems.append(SideBarItemDescription(label: "Arbeitsschritt", icon: "workingStepIcon"))
        }
    }
    
    private func setDiameterInputScreen(){
        cells = [CellDescriptionDescriptionLabel(labelText: "Gib den Durchmesser ein:"),
                 CellDescriptionTextField(),
                 CellDescriptionCalculateButton(labelText: "berechne Drehzahl")]
        
        switch currentCalculation.work! {
        case .drilling:
            sidebarItems[2] = SideBarItemDescription(label: currentCalculation.material!.rawValue, icon: "materialIcon")
            sidebarItems.append(SideBarItemDescription(label: "Durchmesser", icon: "diameterIcon"))
        case .lathing:
            switch currentCalculation.workingStep! {
            case .schruppen, .schlichten:
                sidebarItems[4] = SideBarItemDescription(label: currentCalculation.material!.rawValue, icon: "materialIcon")
                sidebarItems.append(SideBarItemDescription(label: "Durchmesser", icon: "diameterIcon"))
            case .abstechen, .einstechen:
                sidebarItems[3] = SideBarItemDescription(label: currentCalculation.material!.rawValue, icon: "materialIcon")
                sidebarItems.append(SideBarItemDescription(label: "Durchmesser", icon: "diameterIcon"))
            }
        case .milling:
            sidebarItems[4] = SideBarItemDescription(label: currentCalculation.material!.rawValue, icon: "materialIcon")
            sidebarItems.append(SideBarItemDescription(label: "Durchmesser", icon: "diameterIcon"))
        }
        
    }
    
    private func setResultScreen(){
        cells = [CellDescriptionResult(diameterLabel: String(describing: currentCalculation.diameter!), cuttingSpeedLabel: String(describing: currentCalculation.cuttingSpeed!), rotationSpeedLabel: String(describing: currentCalculation.rotationSpeed!)),
                 CellDescriptionRestartButton()]
        
        switch currentCalculation.work! {
        case .drilling:
            sidebarItems[3] = SideBarItemDescription(label: String(currentCalculation.diameter!), icon: "diameterIcon")
            sidebarItems.append(SideBarItemDescription(label: "Drehzahl", icon: "rotationSpeedIcon"))
        case .lathing:
            switch currentCalculation.workingStep! {
            case .schruppen, .schlichten:
                sidebarItems[5] = SideBarItemDescription(label: String(currentCalculation.diameter!), icon: "diameterIcon")
                sidebarItems.append(SideBarItemDescription(label: "Drehzahl", icon: "rotationSpeedIcon"))
            case .abstechen, .einstechen:
                sidebarItems[4] = SideBarItemDescription(label: String(currentCalculation.diameter!), icon: "diameterIcon")
                sidebarItems.append(SideBarItemDescription(label: "Drehzahl", icon: "rotationSpeedIcon"))
            }
        case .milling:
            sidebarItems[5] = SideBarItemDescription(label: String(currentCalculation.diameter!), icon: "diameterIcon")
            sidebarItems.append(SideBarItemDescription(label: "Drehzahl", icon: "rotationSpeedIcon"))
        }
        
        
    }
    
    func restart(){
        sidebarItems = []
        currentCalculation = Calculation()
        setWorkSelectionScreen()
    }
    
    func returnToScreenAt(sideBarIndex: Int) {
        
        if sideBarIndex == sidebarItems.count-1 {
            return
        }
        
        if sideBarIndex == 0 {
            restart()
            return
        }
        
        //Remove sideBarItems
        for index in 1...sidebarItems.count {
            if index >= sideBarIndex+1 {
                sidebarItems.removeLast()
            }
        }
        
        if sideBarIndex == 1 {
            currentCalculation.condition = nil
            currentCalculation.rotationSpeed = nil
            currentCalculation.diameter = nil
            currentCalculation.material = nil
            currentCalculation.tool = nil
            currentCalculation.workingStep = nil
            setCellsForNextScreen()
            return
        }
        
        switch currentCalculation.work! {
        case Work.drilling:
            if sideBarIndex < 5 {
                currentCalculation.rotationSpeed = nil
            }
            if sideBarIndex < 4 {
                currentCalculation.diameter = nil
            }
            if sideBarIndex < 3 {
                currentCalculation.material = nil
            }
            break
            
        case Work.lathing:
         
            switch currentCalculation.workingStep! {
            case .schlichten, .schruppen:
                if sideBarIndex < 7{
                    currentCalculation.rotationSpeed = nil
                }
                if sideBarIndex < 6{
                    currentCalculation.diameter = nil
                }
                if sideBarIndex < 5{
                    currentCalculation.material = nil
                }
                if sideBarIndex < 4{
                    currentCalculation.tool = nil
                }
                if sideBarIndex < 3{
                    currentCalculation.workingStep = nil
                }
                
            case .einstechen, .abstechen:
                if sideBarIndex < 6{
                    currentCalculation.rotationSpeed = nil
                }
                if sideBarIndex < 5{
                    currentCalculation.diameter = nil
                }
                if sideBarIndex < 4{
                    currentCalculation.material = nil
                }
                if sideBarIndex < 3{
                    currentCalculation.workingStep = nil
                }
            }
        case Work.milling:
            if sideBarIndex < 7{
                currentCalculation.rotationSpeed = nil
            }
            if sideBarIndex < 6{
                currentCalculation.diameter = nil
            }
            if sideBarIndex < 5{
                currentCalculation.material = nil
            }
            if sideBarIndex < 4{
                currentCalculation.tool = nil
            }
            if sideBarIndex < 3{
                currentCalculation.workingStep = nil
            }
        }
        setCellsForNextScreen()
    }
}
