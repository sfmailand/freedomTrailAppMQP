//
//  Itinerary.swift
//  FreedomTrailApp
//
//  Created by Samuel Mailand on 2/10/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit


public class Itinerary {
    
    //Properties
    var name: String
    var description: String
    var locations = [Location]()
    
    //Initialization
    
    init?(name: String, description: String){
        
        self.name = name
        self.description = description
        
        if name.isEmpty{
            return nil
        }
    }
    
    func updateName(name: String){
        if !name.isEmpty{
            self.name = name
        }
    }
    
    func addLocation(location: Location){
        locations.append(location)
        print("Added '"+location.name+"' to the itinerary")
        
        print("HERE IS WHAT this contains")
        print(locations)
    }
}
