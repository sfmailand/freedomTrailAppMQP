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
    private var name: String
    private var itineraryDescription: String
    
    private var trailLocationsArray = [String: Location]()
    
    
    
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
    
    init?(name: String, itineraryDescription: String, locations: [String: Location]){
        
        self.name = name
        self.itineraryDescription = itineraryDescription
        super.init()
        
        trailLocationsArray = locations
        
        if name.isEmpty || description.isEmpty{
            return nil
        }
    }
    
    init?(name: String, itineraryDescription: String){
        
        self.name = name
        self.itineraryDescription = itineraryDescription
        super.init()
        
        if name.isEmpty || description.isEmpty{
            return nil
        }
    }
    
    func updateName(name: String){
        if !name.isEmpty{
            self.name = name
        }
    }
    
    func addLocation(trailLocation: Location){
        print(trailLocation.getName())
        self.trailLocationsArray[trailLocation.getName()!] = trailLocation
        print("Adding Location")
        NSNotificationCenter.defaultCenter().postNotificationName(singleItineraryUpdatedNotificationKey, object: self)
        
    }
    
    func setItineraryLocations(trailLocations: [String: Location]){
        self.trailLocationsArray = trailLocations
    }
    
    
    
    
    func getName() -> String{
        return name
    }
    
    func setName(name: String){
        self.name = name
    }
    
    
    //MARK: NSCoding
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(description, forKey: PropertyKey.descriptionKey)
        
        //var locationIndexes: [Int]
        
        //locationIndexes = locationModel.getLocationIndexes(trailLocationsArray)
        
        aCoder.encodeObject(trailLocationsArray, forKey: PropertyKey.locationsKey)
    }
    
    required convenience public init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let description = aDecoder.decodeObjectForKey(PropertyKey.descriptionKey) as! String
        let locations = aDecoder.decodeObjectForKey(PropertyKey.locationsKey) as! [String: Location]
        
        self.init(name: name, itineraryDescription: description, locations: locations)
    }
    
    
    func getLocations() -> [String: Location]{
        return trailLocationsArray
    }
    
    
    func getLocationAtIndex(index: Int) -> Location{
        return Array(trailLocationsArray.values)[index]
    }


    
}
