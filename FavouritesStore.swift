//
//  FavouritesStore.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 26.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation

class FavouritesStore{
    var favourites = [Calculation]()
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("favourites.archive")
    }()
    
    func addFavourite(calculation: Calculation){
        favourites.append(calculation)
    }
    
    func removeFavourite(calculation: Calculation){
        if let index = favourites.index(of: calculation){
            favourites.remove(at: index)
        }
    }
    
    func moveFavourite(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex {
            return
        }
        
        let movedFavourite = favourites[fromIndex]
        favourites.remove(at: fromIndex)
        favourites.insert(movedFavourite, at: toIndex)
    }
    
    func saveChanges() -> Bool {
        return NSKeyedArchiver.archiveRootObject(favourites, toFile: itemArchiveURL.path)
    }
    
    
    
}
