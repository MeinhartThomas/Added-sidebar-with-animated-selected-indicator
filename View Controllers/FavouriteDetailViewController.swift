//
//  FavouriteDetailViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 29.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit

class FavouriteDetailViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var work: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var tool: UILabel!
    @IBOutlet weak var material: UILabel!
    @IBOutlet weak var diameter: UILabel!
    @IBOutlet weak var cuttingSpeed: UILabel!
    @IBOutlet weak var forwardSpeed: UILabel!
    @IBOutlet weak var lubrication: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var rotationSpeed: UITextField!
    var favourite: Favourite!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = UIBezierPath(roundedRect:cardView.bounds,
                                byRoundingCorners:[.topRight, .bottomLeft],
                                cornerRadii: CGSize(width: 20, height:  20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        cardView.layer.mask = maskLayer
        saveButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        name.text = favourite.name
        date.text = dateFormatter.string(from: favourite.date)
        work.text = favourite.work
        condition.text = condition.text
        tool.text = favourite.tool
        material.text = favourite.material
        diameter.text = "\(favourite.diameter)mm"
        cuttingSpeed.text = "\(favourite.cuttingSpeed)"
        forwardSpeed.text = "\(favourite.forwardSpeed)"
        rotationSpeed.text = String(describing: favourite.rotationSpeed)
        //lubrication.text = favourite.lubricaton
    }
    
    
    @IBAction func rotationSpeedLabelChanged(_ sender: Any) {
        saveButton.isEnabled = true
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        let value = Int(rotationSpeed.text!)
        favourite.setValue(value, forKey: "rotationSpeed")
        FavouritesStore.saveContext()
        rotationSpeed.resignFirstResponder()
        saveButton.isEnabled = false
    }
}
