//
//  Cells.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 22.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit

class Cells: UITableViewCell {
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        UIView.animate(withDuration: 0.1) {
            self.transform = highlighted ? CGAffineTransform(scaleX: 0.97, y: 0.97) : CGAffineTransform.identity
            self.addShadow(offsetHeight: highlighted ? 2 : 5)
        }
    }
}
