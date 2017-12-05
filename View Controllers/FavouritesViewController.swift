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

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeFetchedResultsController()
        tableView.backgroundView = UIImageView(image: UIImage(named: "background main area"))
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 105
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

        if editingStyle == .delete {
            let favourite = fetchedResultsController.object(at: indexPath)
            FavouritesStore.managedObjectContext.delete(favourite)
            FavouritesStore.saveContext()
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
