//
//  FavouritesStore.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 26.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation
import CoreData

class FavouritesStore: NSObject{
    
    static var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static let persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "favourites")
        container.viewContext.mergePolicy = NSRollbackMergePolicy
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        
        
        return container
    }()
    
    
    // MARK: - Core Data Saving support
    
    class func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    //var favourites = [Calculation]()
    
//    let itemArchiveURL: URL = {
//        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentDirectory = documentsDirectories.first!
//        return documentDirectory.appendingPathComponent("favourites.archive")
//    }()
//
//    init() {
//        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Calculation] {
//            favourites = archivedItems
//        }
//    }
//
//    func saveChanges() -> Bool {
//        print("Saving favourites to: \(itemArchiveURL.path)")
//        return NSKeyedArchiver.archiveRootObject(favourites, toFile: itemArchiveURL.path)
//    }
//
//    func addFavourite(calculation: Calculation){
//        favourites.append(calculation)
//    }
//
//    func removeFavourite(calculation: Calculation){
//        if let index = favourites.index(of: calculation){
//            favourites.remove(at: index)
//        }
//    }
//
//    func moveFavourite(from fromIndex: Int, to toIndex: Int){
//        if fromIndex == toIndex {
//            return
//        }
//
//        let movedFavourite = favourites[fromIndex]
//        favourites.remove(at: fromIndex)
//        favourites.insert(movedFavourite, at: toIndex)
//    }
}
