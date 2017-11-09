//
//  DiameterViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 09.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation
import UIKit

class DiameterViewController: UIViewController {
    var workingStep: WorkingStep?
    var condition: Condition?
    var material: Material?
    
    
    @IBOutlet weak var textFieldDiameter: UITextField!
    @IBOutlet weak var textFieldForwardSpeed: UITextField!
    
    
    @IBAction func calculateRotationSpeedPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let resultView = storyboard.instantiateViewController(withIdentifier: "resultView") as! ResultViewController
        resultView.rotationSpeedLabel = //REVCALC
        self.present(resultView, animated: false, completion: nil)
    }
    
    
}
