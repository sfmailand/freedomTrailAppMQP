//
//  YelpLocation.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 3/20/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import Foundation
import UIKit


public class YelpLocation: Location {
    
    //Initialization
    
    
    override init(name: String, photo: UIImage?, gpsLat: Double, gpsLong : Double){
        super.init(name: name, photo: photo, gpsLat: gpsLat, gpsLong: gpsLong)
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        //let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as! UIImage
        let gpsLong = aDecoder.decodeObjectForKey(PropertyKey.gpsLongKey) as! Double
        let gpsLat = aDecoder.decodeObjectForKey(PropertyKey.gpsLatKey) as! Double
        self.init(name: name, photo: nil, gpsLat: gpsLat, gpsLong: gpsLong)
    }
    
    
    
    
}
