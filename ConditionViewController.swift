//
//  ConditionViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 09.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit

class ConditionViewController: UIViewController {
    var workingStep: WorkingStep?
    
    @IBAction func optimalButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func normalButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func badButtonPressed(_ sender: Any) {
        presentNextView(condition: Condition.bad)
    }
    
    func presentNextView(condition: Condition){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let materialView = storyboard.instantiateViewController(withIdentifier: "materialView") as! MaterialViewController
        materialView.workingStep = workingStep
        materialView.condition = condition
        self.present(materialView, animated: false, completion: nil)
    }
    
}
