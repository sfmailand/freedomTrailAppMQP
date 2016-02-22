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
    
    private var trailLocationIndex: Int
    
    init(name: String, photo: UIImage?, index: Int){
        self.trailLocationIndex = index
        super.init(name: name, photo: photo)
    }
    
    
    func getTrailLocationIndex() -> Int{
        return trailLocationIndex
    }

}
