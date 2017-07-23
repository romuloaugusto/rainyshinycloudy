//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Romulo Augusto on 10/07/17.
//  Copyright © 2017 Romulo Augusto. All rights reserved.
//

import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    
    private init () {}
    
    var latitude: Double!
    var longitude: Double!
}
