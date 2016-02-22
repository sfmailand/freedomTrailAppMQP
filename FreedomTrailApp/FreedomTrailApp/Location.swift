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
    
    //Initialization
    
    init(name: String, photo: UIImage?){
        self.name = name
        self.photo = photo
    }
    
    func getName() -> String?{
        return name
    }
    
    func getPhoto() -> UIImage?{
        return photo!
    }
    
}
