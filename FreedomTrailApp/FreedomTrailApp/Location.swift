//
//  Location.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/22/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit


public class Location{
    
    //Properties
    private var name: String
    private var photo: UIImage?
    private var gpsLong: Double
    private var gpsLat: Double
    
    //Initialization
    
    init(name: String, photo: UIImage?, gpsLat: Double, gpsLong: Double){
        self.name = name
        self.photo = photo
        self.gpsLat = gpsLat
        self.gpsLong = gpsLong
    }
    
    func getName() -> String?{
        return name
    }
    
    func getPhoto() -> UIImage?{
        return photo
    }
    
    func getGpsLat() -> Double{
        return gpsLat
    }
    
    func getGpsLong() -> Double{
        return gpsLong
    }
    
}
