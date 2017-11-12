//
//  ToolViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 12.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation
import UIKit

class ToolViewController: UIViewController {
    var work: Work?
    var workingStep: WorkingStep?
    var condition: Condition?
    
    @IBAction func HSSButtonPressed(_ sender: Any) {
        presentNextView(tool: Tool.HSS)
    }
    
    @IBAction func HMButtonPressed(_ sender: Any) {
        presentNextView(tool: Tool.HM)
    }
    
    func presentNextView(tool: Tool){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let materialView = storyboard.instantiateViewController(withIdentifier: "materialView") as! MaterialViewController
        materialView.work = work
        materialView.condition = condition
        materialView.workingStep = workingStep
        materialView.tool = tool
        self.present(materialView, animated: false, completion: nil)
    }
    
}
