//
//  Itinerary.swift
//  FreedomTrailApp
//
//  Created by Samuel Mailand on 2/10/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import Foundation

//May 14th, 2016: 9AM
let defaultStartTime = NSDate(timeIntervalSince1970: 1463230800)


public class Itinerary: NSObject, NSCoding {
    
    //Properties
    private var name: String
    private var itineraryDescription: String
    private var startTime: NSDate
    
    private var trailLocationsArray = [Location]()
    
    
    
    //MARK: Archving Paths
    
    static let DocumentDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    
    static let ArchiveURL = DocumentDirectory.URLByAppendingPathComponent("itineraries")
    
    
    //MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let descriptionKey = "description"
        static let locationsKey = "locations"
        static let startTimeKey = "startTime"
    }
    //Initialization
    
    init?(name: String, itineraryDescription: String, locations: [Location], startTime: NSDate){
        
        self.name = name
        self.itineraryDescription = itineraryDescription
        self.startTime = startTime
        super.init()
        
        trailLocationsArray = locations
        
        if name.isEmpty || description.isEmpty{
            return nil
        }
    }
    
    init?(name: String, itineraryDescription: String){
        
        self.name = name
        self.itineraryDescription = itineraryDescription
        self.startTime = defaultStartTime
        super.init()
        
        if name.isEmpty || description.isEmpty{
            return nil
        }
    }
    
    func getNumberOfLocations() -> Int{
        
        return trailLocationsArray.count
    }
    
    func updateName(name: String){
        if !name.isEmpty{
            self.name = name
        }
    }
    
    
    
    func addLocation(trailLocation: Location){
        self.trailLocationsArray.append(trailLocation)
        print("Location Added - Notification")
        NSNotificationCenter.defaultCenter().postNotificationName(singleItineraryUpdatedNotificationKey, object: self)
        
    }
    
    func setItineraryLocations(trailLocations: [Location]){
        self.trailLocationsArray = trailLocations
    }
    
    func setLocationAtIndex(index: Int, location: Location){
        print("Change number: " + String(index))
        trailLocationsArray[index] = location
    }
    
    
    
    func getLocations() -> [Location]{
        return trailLocationsArray
    }
    
    
    func getLocationAtIndex(index: Int) -> Location{
        return trailLocationsArray[index]
    }
    
    func deleteLocation(index: Int){
        trailLocationsArray.removeAtIndex(index)
        print("Location Deleted - Notification")
        NSNotificationCenter.defaultCenter().postNotificationName(singleItineraryUpdatedNotificationKey, object: self)
    }
    
    
    func getName() -> String{
        return name
    }
    
    func getStartTime() -> NSDate{
        return self.startTime
    }
    
    func setStartTime(startTime: NSDate){
        self.startTime = startTime
    }
    
    func setName(name: String){
        self.name = name
    }
    
    public func swapLocations(newIndex: Int, oldIndex: Int){
        swap(&trailLocationsArray[newIndex], &trailLocationsArray[oldIndex])
        print("Locations Swapped - Notification")
        NSNotificationCenter.defaultCenter().postNotificationName(singleItineraryUpdatedNotificationKey, object: self)
    }
    
    
    //MARK: NSCoding
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(description, forKey: PropertyKey.descriptionKey)
        aCoder.encodeObject(startTime, forKey: PropertyKey.startTimeKey)
        aCoder.encodeObject(trailLocationsArray, forKey: PropertyKey.locationsKey)
    }
    
    required convenience public init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let description = aDecoder.decodeObjectForKey(PropertyKey.descriptionKey) as! String
        let locations = aDecoder.decodeObjectForKey(PropertyKey.locationsKey) as! [Location]
        let startTime = aDecoder.decodeObjectForKey(PropertyKey.startTimeKey) as! NSDate
        self.init(name: name, itineraryDescription: description, locations: locations, startTime: startTime)
    }



    
}
