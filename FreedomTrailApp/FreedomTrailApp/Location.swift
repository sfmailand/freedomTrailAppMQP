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
    
    
    //MARK: Archiving Paths
    
    static let DocumentDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentDirectory.URLByAppendingPathComponent("locations")
    
    
    //Initialization
    
    init?(name: String, photo: UIImage?){
        self.name = name
        self.photo = photo
    }

}
