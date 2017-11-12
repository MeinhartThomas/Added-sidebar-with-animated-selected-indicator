//
//  ConditionViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 09.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit

class ConditionViewController: UIViewController {
    var work: Work?
    
    @IBAction func optimalButtonPressed(_ sender: Any) {
        presentNextView(condition: Condition.optimal)
    }
    
    @IBAction func normalButtonPressed(_ sender: Any) {
        presentNextView(condition: Condition.normal)
    }
    
    @IBAction func badButtonPressed(_ sender: Any) {
        presentNextView(condition: Condition.bad)
    }
    
    func presentNextView(condition: Condition){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch work {
            case .drilling?:
                let materialView = storyboard.instantiateViewController(withIdentifier: "materialView") as! MaterialViewController
                materialView.work = work
                materialView.condition = condition
                self.present(materialView, animated: false, completion: nil)
            case .lathing?, .milling?:
                let workingStepView = storyboard.instantiateViewController(withIdentifier: "workingStepView") as! WorkingStepViewController
                workingStepView.condition = condition
                workingStepView.work = work
                self.present(workingStepView, animated: false, completion: nil)
            case .none:
                break
        }
    }
    
}
