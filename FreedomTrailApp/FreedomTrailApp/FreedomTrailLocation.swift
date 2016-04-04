//
//  Locations.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 1/29/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit


public class FreedomTrailLocation: Location {
    
    //Initialization

    
    override init(name: String, photo: UIImage?, gpsLat: Double, gpsLong : Double, locationDescription: String, summary: String){
        super.init(name: name, photo: photo, gpsLat: gpsLat, gpsLong: gpsLong, locationDescription: locationDescription, summary: summary)
    }

    required convenience public init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as! UIImage
        let gpsLong = aDecoder.decodeObjectForKey(PropertyKey.gpsLongKey) as! Double
        let gpsLat = aDecoder.decodeObjectForKey(PropertyKey.gpsLatKey) as! Double
        let summary = aDecoder.decodeObjectForKey(PropertyKey.summaryKey) as! String
        let description = aDecoder.decodeObjectForKey(PropertyKey.descriptionKey) as! String
        self.init(name: name, photo: photo, gpsLat: gpsLat, gpsLong: gpsLong, locationDescription: description, summary: summary)
    }


}
