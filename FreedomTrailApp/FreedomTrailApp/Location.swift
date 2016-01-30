//
//  Locations.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 1/29/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit


public class Location {
    
    //Properties
    var name: String
    var photo: UIImage?
    
    //Initialization
    
    init?(name: String, photo: UIImage?){
        self.name = name
        self.photo = photo
        
        if name.isEmpty{
            return nil
        }
    }
}
