//
//  Favourite+CoreDataProperties.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 27.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var work: String?
    @NSManaged public var tool: String?
    @NSManaged public var condition: String?
    @NSManaged public var workingStep: String?
    @NSManaged public var material: String?
    @NSManaged public var diameter: Double
    @NSManaged public var cuttingSpeed: Int32
    @NSManaged public var rotationSpeed: Int32
    @NSManaged public var forwardSpeed: Double
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var date: Date
    

}
