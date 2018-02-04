//
//  FavouriteDetailViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 29.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit

class FavouriteDetailViewController: UIViewController {

    // CardView
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var blackCardView: UIView!
    
    // Labels white
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rotationSpeed: UITextField!
    
    //Labels black
    @IBOutlet weak var work: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var tool: UILabel!
    @IBOutlet weak var material: UILabel!
    @IBOutlet weak var diameter: UILabel!
    @IBOutlet weak var cuttingSpeed: UILabel!
    @IBOutlet weak var forwardSpeed: UILabel!
    @IBOutlet weak var lubrication: UILabel!
    @IBOutlet weak var notes: UITextView!
    
    @IBOutlet weak var editBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var editButton: UIButton!
    
    var favourite: Favourite!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //backButton
        let  backButtonItem = UIBarButtonItem()
        backButtonItem.tintColor = #colorLiteral(red: 0.216707319, green: 0.2553483248, blue: 0.2605955899, alpha: 1)
        backButtonItem.title = "Zurück"
        navigationItem.backBarButtonItem = backButtonItem
        
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.216707319, green: 0.2553483248, blue: 0.2605955899, alpha: 1)
    }
    
    
    override func viewWillLayoutSubviews() {
        //rounded corners
        let maskLayerWhite = CAShapeLayer()
        let path = UIBezierPath(roundedRect:cardView.bounds,
                                byRoundingCorners:[.topRight, .bottomLeft],
                                cornerRadii: CGSize(width: 20, height:  20))
        maskLayerWhite.path = path.cgPath
        cardView.layer.mask = maskLayerWhite
        
        let maskLayerBlack = CAShapeLayer()
        let pathForBlack = UIBezierPath(roundedRect: blackCardView.bounds, byRoundingCorners: [.topRight, .bottomLeft], cornerRadii: CGSize(width: 20, height:  20))
        maskLayerBlack.path = pathForBlack.cgPath
        blackCardView.layer.mask = maskLayerBlack
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        //name.isEnabled = false
        //name.allowsEditingTextAttributes = false
        name.isEditable = false
        rotationSpeed.isEnabled = false
        name.backgroundColor = #colorLiteral(red: 0.2105649412, green: 0.2510686517, blue: 0.2554402947, alpha: 1)
        name.textColor = UIColor.white
        name.clipsToBounds = true
        name.layer.cornerRadius = 5


        
        //filling labels
        name.text = favourite.name
        date.text = dateFormatter.string(from: favourite.date)
        //work.text = favourite.work

        tool.text = favourite.tool
     //FIx this
//        if favourite.work == "Bohren" {
//            if let sview = tool.superview{
//                sview.removeFromSuperview()
//            }
//        }
        
        condition.text = condition.text
        material.text = favourite.material
        diameter.text = "\(favourite.diameter)mm"
        cuttingSpeed.text = "\(favourite.cuttingSpeed)"
        forwardSpeed.text = "\(favourite.forwardSpeed)"
        rotationSpeed.text = String(describing: favourite.rotationSpeed)
        //lubrication.text = favourite.lubcrication
        
        if favourite.notes == "" {
            notes.text = "noch keine Notiz hinzugefügt"
            editButton.setTitle("hinzufügen", for: editButton.state)
        } else {
            notes.text = favourite.notes
            editButton.setTitle("anzeigen", for: editButton.state)
        }

        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.216707319, green: 0.2553483248, blue: 0.2605955899, alpha: 1)
    }
    
    
    @IBAction func rotationSpeedLabelChanged(_ sender: Any) {
        //saveButton.isEnabled = true
        
    }
    
    @IBAction func editBarButtonItem(_ sender: Any) {
        if editBarButtonItem.title == "Speichern" {
            
            rotationSpeed.isEnabled = false
            name.isEditable = false
            
            rotationSpeed.borderStyle = .none
            name.backgroundColor = #colorLiteral(red: 0.2105649412, green: 0.2510686517, blue: 0.2554402947, alpha: 1)
            rotationSpeed.backgroundColor = #colorLiteral(red: 0.2105649412, green: 0.2510686517, blue: 0.2554402947, alpha: 1)

            rotationSpeed.textColor = UIColor.white
            name.textColor = UIColor.white
            rotationSpeed.resignFirstResponder()

            let value = Int(rotationSpeed.text!)
            let nameValue = name.text!
            favourite.setValue(nameValue, forKey: "name")
            favourite.setValue(value, forKey: "rotationSpeed")
            FavouritesStore.saveContext()
            editBarButtonItem.title = "Bearbeiten"
        } else {
            rotationSpeed.borderStyle = .roundedRect
            rotationSpeed.backgroundColor = UIColor.white
            name.backgroundColor = UIColor.white
            rotationSpeed.textColor = UIColor.black
            name.textColor = UIColor.black
            rotationSpeed.isEnabled = true
            name.isEditable = true
            rotationSpeed.becomeFirstResponder()
            editBarButtonItem.title = "Speichern"
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "editNotes"?:
                let notesController = segue.destination as! NotesViewController
                    notesController.favourite = favourite
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
}
