//
//  MaterialViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 09.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation
import UIKit

class MaterialViewController: UIViewController {
    var work: Work?
    var workingStep: WorkingStep?
    var condition: Condition?
    var tool: Tool?
    
    @IBAction func steelOverButtonPressed(_ sender: Any) {
        presentNextView(material: Material.steelOver500)
    }
    
    @IBAction func steelUnderButtonPressed(_ sender: Any) {
        presentNextView(material: Material.steelUnder500)
    }
    
    @IBAction func aluminiumButtonPressed(_ sender: Any) {
        presentNextView(material: Material.aluminium)
    }
    
    @IBAction func plasticButtonPressed(_ sender: Any) {
        presentNextView(material: Material.plastic)
    }
    
    @IBAction func brassBronzeButtonPressed(_ sender: Any) {
        presentNextView(material: Material.brassBronze)
    }
    
    func presentNextView(material: Material){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let diameterView = storyboard.instantiateViewController(withIdentifier: "diameterView") as! DiameterViewController
        diameterView.work = work
        diameterView.condition = condition
        diameterView.material = material
        diameterView.tool = tool
        self.present(diameterView, animated: false, completion: nil)
    }

}
