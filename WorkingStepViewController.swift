//
//  WorkingStepViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 12.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation
import UIKit

class WorkingStepViewController: UIViewController {
    var work: Work?
    var condition: Condition?

    @IBOutlet weak var abstechenButton: UIButton!
    @IBOutlet weak var einstechenButton: UIButton!

    override func viewDidLoad() {
        if work == Work.milling {
            abstechenButton.removeFromSuperview()
            einstechenButton.removeFromSuperview()
        }
    }

    @IBAction func SchlichtenButtonPressed(_ sender: Any) {
        presentNextView(workingStep: WorkingStep.schlichten)
    }

    @IBAction func SchruppenButtonPressed(_ sender: Any) {
        presentNextView(workingStep: WorkingStep.schruppen)
    }

    @IBAction func AbstechenButtonPressed(_ sender: Any) {
        presentNextView(workingStep: WorkingStep.abstechen)
    }

    @IBAction func EinstechenButtonPressed(_ sender: Any) {
        presentNextView(workingStep: WorkingStep.einstechen)
    }
    
    func presentNextView(workingStep: WorkingStep){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch work {
        case .drilling?:
            break
        case .lathing?:
            if (workingStep == WorkingStep.schlichten) || (workingStep == WorkingStep.schruppen) {
                let toolView = storyboard.instantiateViewController(withIdentifier: "toolView") as! ToolViewController
                toolView.condition = condition
                toolView.work = work
                toolView.workingStep = workingStep
                self.present(toolView, animated: false, completion: nil)
            }
            if (workingStep == WorkingStep.abstechen) || (workingStep == WorkingStep.einstechen) {
                let materialView = storyboard.instantiateViewController(withIdentifier: "materialView") as! MaterialViewController
                materialView.condition = condition
                materialView.work = work
                materialView.workingStep = workingStep
                self.present(materialView, animated: false, completion: nil)
            }
        case .milling?:
            let materialView = storyboard.instantiateViewController(withIdentifier: "materialView") as! MaterialViewController
            materialView.condition = condition
            materialView.work = work
            materialView.workingStep = workingStep
            self.present(materialView, animated: false, completion: nil)
        case .none:
            break
        }
    }

}

