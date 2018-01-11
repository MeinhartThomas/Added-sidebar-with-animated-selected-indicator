//
//  FavouritesViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 26.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit
import CoreData

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var fetchedResultsController:NSFetchedResultsController<Favourite>!

    //@IBOutlet weak var backButton: UIBarButtonItem!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FetchedResultsController
        initializeFetchedResultsController()
        
        //NavigationBar title
        let navigationBarTitle = UILabel()
        navigationBarTitle.text = "Favoriten"
        navigationBarTitle.tintColor = #colorLiteral(red: 0.216707319, green: 0.2553483248, blue: 0.2605955899, alpha: 1)
        let font = UIFont.systemFont(ofSize: 24, weight: .light)
        navigationBarTitle.font = font
        navigationItem.titleView = navigationBarTitle
        
        //delete Button
        navigationItem.leftBarButtonItem?.title = "Löschen"
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.216707319, green: 0.2553483248, blue: 0.2605955899, alpha: 1)
        
        let  backButtonItem = UIBarButtonItem()
        backButtonItem.tintColor = #colorLiteral(red: 0.216707319, green: 0.2553483248, blue: 0.2605955899, alpha: 1)
        backButtonItem.title = "Zurück"
        navigationItem.backBarButtonItem = backButtonItem
        
        //tableView
        tableView.backgroundView = UIImageView(image: UIImage(named: "background main area"))
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "showFavouriteDetails"?:
            if let indexPath = tableView.indexPathForSelectedRow {
                let favourite = fetchedResultsController.object(at: indexPath)
                let favouriteDetailViewController = segue.destination as! FavouriteDetailViewController
                favouriteDetailViewController.favourite = favourite
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<Favourite>(entityName: String(describing: Favourite.self))
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        fetchedResultsController = NSFetchedResultsController<Favourite>(fetchRequest: request, managedObjectContext: FavouritesStore.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
   
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if(self.tableView.isEditing == true){
            self.tableView.setEditing(false, animated: true)
            self.navigationItem.leftBarButtonItem?.title = "Löschen"
        }else{
            self.tableView.setEditing(true, animated: true)
            self.navigationItem.leftBarButtonItem?.title = "Fertig"
        }
    }
    
    // MARK: - UITableViewDataSource methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as! FavouriteCell
        let favourite = fetchedResultsController.object(at: indexPath)
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        cell.name.text = favourite.name
        cell.rotationSpeed.text = "\(String(favourite.rotationSpeed)) U/min"
        cell.date.text = dateFormatter.string(from: favourite.date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let favourite = fetchedResultsController.object(at: indexPath)

        if editingStyle == .delete {
            let ac = UIAlertController(title: "Löschen", message: "Bist du sicher das du den Favourite '\(favourite.name!)' löschen möchtest?", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Ja", style: .default, handler: {(aa: UIAlertAction) -> Void in
                FavouritesStore.managedObjectContext.delete(favourite)
                FavouritesStore.saveContext()
                
            }))
                
            ac.addAction(UIAlertAction(title: "Nein", style: .cancel, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - FetchedResultController Updates
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }

}
