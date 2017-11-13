//
//  DiameterViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 09.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation
import UIKit

class DiameterViewController: UIViewController, UITextFieldDelegate {
    var work: Work?
    var condition: Condition?
    var material: Material?
    var tool: Tool?
    var diameter: Double?
    var rotationalSpeed: Double?
    
    
    @IBOutlet weak var textFieldDiameter: UITextField!
    @IBOutlet weak var textFieldForwardSpeed: UITextField!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func diameterFieldEditingChanged(_ sender: Any) {
        if let text = textFieldDiameter.text, let number = numberFormatter.number(from: text){
            diameter = number.doubleValue
        } else {
            diameter = nil
        }
    }
    
//    @IBAction func calculateRotationSpeedPressed(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let resultView = storyboard.instantiateViewController(withIdentifier: "resultView") as! ResultViewController
//        var revCalc = RevCalc()
//        rotationalSpeed = revCalc.calculateDrillingRotationalSpeed(condition: condition!, material: material!, diameter: diameter!)
//        
//        resultView.rotationSpeed = rotationalSpeed
//        self.present(resultView, animated: false, completion: nil)
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let decimalSeparator = ","
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
    
}
