//
//  Favourite+CoreDataClass.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 27.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Favourite)
public class Favourite: NSManagedObject {
    
    class func addNew(calculation:Calculation) {
        let favourite = NSEntityDescription.insertNewObject(forEntityName: String(describing: Favourite.self), into: FavouritesStore.managedObjectContext) as! Favourite
        favourite.name = calculation.name
        favourite.notes = calculation.notes
        favourite.work = calculation.work?.rawValue
        favourite.workingStep = calculation.workingStep?.rawValue
        favourite.condition = calculation.condition?.rawValue
        favourite.material = calculation.material?.rawValue
        favourite.tool = calculation.tool?.rawValue
        favourite.cuttingSpeed = Int32(calculation.cuttingSpeed!)
        favourite.forwardSpeed = calculation.forwardSpeed ?? 0
        favourite.rotationSpeed = Int32(calculation.rotationSpeed!)
        favourite.diameter = calculation.diameter!
        favourite.date = Date()
        
        FavouritesStore.saveContext()
    }

}
