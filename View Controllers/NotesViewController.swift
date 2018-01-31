//
//  NotesViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 11.01.18.
//  Copyright © 2018 Thomas Meinhart. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var notesTextView: UITextView!
    var favourite: Favourite!

    @IBOutlet weak var cardView: UIView!
    
    
    @IBAction func editButtonPressed(_ sender: Any) {
        if !notesTextView.isEditable {
            notesTextView.isEditable = true
            notesTextView.becomeFirstResponder()
            editButton.title = "Speichern"
        } else {
            notesTextView.resignFirstResponder()
            favourite.setValue(notesTextView.text, forKey: "notes")
            FavouritesStore.saveContext()
            editButton.title = "Bearbeiten"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //NavigationBar title
        let navigationBarTitle = UILabel()
        navigationBarTitle.text = "Notizen"
        navigationBarTitle.tintColor = #colorLiteral(red: 0.216707319, green: 0.2553483248, blue: 0.2605955899, alpha: 1)
        let font = UIFont.systemFont(ofSize: 24, weight: .light)
        navigationBarTitle.font = font
        navigationItem.titleView = navigationBarTitle

    }
    
    override func viewWillAppear(_ animated: Bool) {
        notesTextView.text = favourite.notes
        
        //rounded corners
        let maskLayerWhite = CAShapeLayer()
        let path = UIBezierPath(roundedRect:cardView.bounds,
                                byRoundingCorners:[.topRight, .bottomLeft],
                                cornerRadii: CGSize(width: 20, height:  20))
        maskLayerWhite.path = path.cgPath
        cardView.layer.mask = maskLayerWhite
    }
}
