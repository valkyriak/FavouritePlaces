//
//  Places+CoreDataProperties.swift
//  FavouritePlaces
//
//  Created by Kane Clerke on 30/4/19.
//  Copyright © 2019 Kane Clerke. All rights reserved.
//
//

import Foundation
import CoreData


extension Places {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Places> {
        return NSFetchRequest<Places>(entityName: "Places")
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double

}
