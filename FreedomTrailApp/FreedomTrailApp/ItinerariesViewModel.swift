//
//  ItineraryList.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/15/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import Foundation

public class ItinerariesViewModel{
    
    //Properties
    //private var itineraries = [Itinerary]()
    
    private var itineraries = [String: Itinerary]()
    
    
    private var tempItinerary: Itinerary!
    
    private var selectedItineraryName: String!
    
    private var isCreatingNewItinerary: Bool!

    
    struct PropertyKey{
        static let itinerariesKey = "itineraries"
    }
    //Initialization
    
    
    init?(){
        isCreatingNewItinerary = false
        if (loadItineraries() != nil){
            itineraries = loadItineraries()!
        }
        else{
            print("No Saved Itineraries")
        }
    }
    
    func saveItinerary(){
        if(isCreatingNewItinerary == true){
            self.itineraries[tempItinerary.getName()] = tempItinerary
            print("Appending Itinerary")
            NSNotificationCenter.defaultCenter().postNotificationName(itinerariesListNotificationKey, object: self)
            storeItineraries()
            tempItinerary = nil
            isCreatingNewItinerary = false
        }
        else{
            NSNotificationCenter.defaultCenter().postNotificationName(itinerariesListNotificationKey, object: self)
            storeItineraries()
        }
    }
    
    
    func getCount() -> Int{
        return itineraries.count
    }
    
    
    
    
    
    //For temparary itinerary when creating a new one
    
    func tmpInitItinerary(){
        isCreatingNewItinerary = true
        tempItinerary = Itinerary(name: "Untitled Itinerary", itineraryDescription: "No Description", locationIndexes: [])
    }
    
    func addLocationToItinerary(location: FreedomTrailLocation){
        if(isCreatingNewItinerary == true){
            tempItinerary.addLocation(location)
        }
        else{
            itineraries[selectedItineraryName]!.addLocation(location)
        }
    }
    
    func changeItineraryName(name: String){
        if(isCreatingNewItinerary == true){
            tempItinerary.updateName(name)
        }
    }
    
    
    func setCurrentItinerary(name: String){
        selectedItineraryName = name
    }
    
    
    func getCurrentItinerary() -> Itinerary{
        if(isCreatingNewItinerary == true){
            return tempItinerary
        }
        else{
            return itineraries[selectedItineraryName]!
        }
    }
    
    
    func getItineraryWithName(name: String) -> Itinerary?{
        if((itineraries[name]) != nil){
            return itineraries[name]!
        }
        else{
            return nil
        }
    }

    
    func areCreatingNewItineary() -> Bool{
        return isCreatingNewItinerary
    }
    
    
    //MARK: NSCoding
    
    func storeItineraries(){
        let isSuccessfullSave = NSKeyedArchiver.archiveRootObject(itineraries, toFile: Itinerary.ArchiveURL.path!)
        
        if !isSuccessfullSave{
            print("Could not save itineraries...")
        }
        
    }
    
    
    func loadItineraries() -> [String: Itinerary]?{
        print("Loading Itineratires")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Itinerary.ArchiveURL.path!) as? [String: Itinerary]
    }
    
    
    func getItineraryArray() -> [Itinerary]{
        return Array(itineraries.values)
    }
    
    
}
