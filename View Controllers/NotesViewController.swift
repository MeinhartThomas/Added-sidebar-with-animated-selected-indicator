//
//  NotesViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 11.01.18.
//  Copyright © 2018 Thomas Meinhart. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var notesTextField: UITextField!
    var favourite: Favourite!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTextField.becomeFirstResponder()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        notesTextField.text = favourite.notes
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        favourite.setValue(notesTextField.text, forKey: "notes")
        FavouritesStore.saveContext()
    }

}
