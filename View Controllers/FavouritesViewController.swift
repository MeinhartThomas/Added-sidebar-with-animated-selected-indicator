//
//  FavouritesViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 26.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "background main area"))
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 105
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    // MARK: - UITableViewDataSource methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tabBar = tabBarController as! TabBarController
        return tabBar.favouritesStore.favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tabBar = tabBarController as! TabBarController
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as! FavouriteCell
        print("Test")

        let favourite = tabBar.favouritesStore.favourites[indexPath.row]
        
        cell.name.text = favourite.name ?? favourite.work?.rawValue
        cell.rotationSpeed.text = String(describing: favourite.rotationSpeed)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let tabBar = tabBarController as! TabBarController
            let favouriteStore = tabBar.favouritesStore!
            let favourite = favouriteStore.favourites[indexPath.row]
            
            let title = "Lösche \(String(describing: favourite.name))"
            let message = "Bist du sicher das du diesen Favouriten löschen möchtest?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel , handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                //Remove the item from the store
                favouriteStore.removeFavourite(calculation: favourite)
                
                //Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            })
            
            ac.addAction(deleteAction)
            
            //Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    
    

    
    

}
