//
//  NavigationController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 22.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(named: "background header"), for: .default)
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 150)
        
    }
}
