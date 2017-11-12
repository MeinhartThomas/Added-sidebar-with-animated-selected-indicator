//
//  ResultViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 09.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    var work: Work?
    var condition: Condition?
    var material: Material?
    var diameter: Double?
    var forwardSpeed: Double?
    var rotationSpeed: Double?
    
    @IBOutlet weak var rotationSpeedLabel: UILabel!

    override func viewDidLoad() {
        rotationSpeedLabel.text = String(format:"%.2f", rotationSpeed!)
    }
    
}
