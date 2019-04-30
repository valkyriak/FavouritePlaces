//
//  Animal.swift
//  FavouritePlaces
//
//  Created by Kane Clerke on 8/4/19.
//  Copyright © 2019 Kane Clerke. All rights reserved.
//

import Foundation

/// The class model used for when appending, and editing information from views.
class Places: Codable {
    /// The name of the address
    var name: String = ""
    /// The location of the address
    var address: String = ""
    /// The latitude of the address
    var latitude: Double
    /// The longitude of the address
    var longitude: Double
    
    /// Class initialisation
    init(name: String, address: String, latitude: Double, longitude: Double) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}
