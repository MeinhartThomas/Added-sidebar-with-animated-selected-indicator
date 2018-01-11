//
//  NotesViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 11.01.18.
//  Copyright © 2018 Thomas Meinhart. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var notesTextView: UITextView!
    var favourite: Favourite!

    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTextView.becomeFirstResponder()
        
        //rounded Corners
        let maskLayerWhite = CAShapeLayer()
        let path = UIBezierPath(roundedRect:cardView.bounds,
                                byRoundingCorners:[.topRight, .bottomLeft],
                                cornerRadii: CGSize(width: 20, height:  20))
        maskLayerWhite.path = path.cgPath
        cardView.layer.mask = maskLayerWhite
        
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        favourite.setValue(notesTextView.text, forKey: "notes")
        FavouritesStore.saveContext()
    }

}
