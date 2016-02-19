//
//  Itinerary.swift
//  FreedomTrailApp
//
//  Created by Samuel Mailand on 2/10/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import Foundation

public class Itinerary: NSObject, NSCoding {
    
    //Properties
    var name: String
    var itineraryDescription: String
    var locations = [Location]()
    
    
    //MARK: Archving Paths
    
    static let DocumentDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    
    static let ArchiveURL = DocumentDirectory.URLByAppendingPathComponent("itineraries")
    
    
    //MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let descriptionKey = "description"
        static let locationsKey = "locations"
    }
    //Initialization
    
    init?(name: String, itineraryDescription: String, locations: [Location]){
        
        self.name = name
        self.itineraryDescription = itineraryDescription
        self.locations = []
        super.init()
        
        
        print("Init Itinerary")
        
        if name.isEmpty || description.isEmpty{
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
        NSNotificationCenter.defaultCenter().postNotificationName(singleItineraryUpdatedNotificationKey, object: self)
        
    }
    
    func setItineraryLocations(locations: [Location]){
        self.locations = locations
    }
    
    
    //MARK: NSCoding
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(description, forKey: PropertyKey.descriptionKey)
    }
    
    required convenience public init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let description = aDecoder.decodeObjectForKey(PropertyKey.descriptionKey) as! String
        self.init(name: name, itineraryDescription: description, locations: [])
    }

    
}
