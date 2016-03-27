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
    
    private var itineraries = [Itinerary]()
    
    
    private var tempItinerary: Itinerary!
    
    private var selectedItineraryIndex: Int!
    
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
            self.itineraries.append(tempItinerary)
            print("Appending Itinerary")
            notifyOfItineraryChange()
            storeItineraries()
            tempItinerary = nil
            isCreatingNewItinerary = false
        }
        else{
            notifyOfItineraryChange()
            storeItineraries()
        }
    }
    
    
    func getCount() -> Int{
        return itineraries.count
    }
    
    
    
    
    
    //For temparary itinerary when creating a new one
    
    func tmpInitItinerary(){
        isCreatingNewItinerary = true
        tempItinerary = Itinerary(name: "Untitled Itinerary", itineraryDescription: "No Description")
    }
    
    func addLocationToItinerary(location: Location){
        if(isCreatingNewItinerary == true){
            tempItinerary.addLocation(location)
        }
        else{
            itineraries[selectedItineraryIndex].addLocation(location)
        }
    }
    
    func changeItineraryName(name: String){
        if(isCreatingNewItinerary == true){
            tempItinerary.updateName(name)
        }
    }
    
    
    func setCurrentItinerary(index: Int){
        selectedItineraryIndex = index
    }
    
    
    func getCurrentItinerary() -> Itinerary{
        if(isCreatingNewItinerary == true){
            return tempItinerary
        }
        else{
            return itineraries[selectedItineraryIndex]
        }
    }
    
    
    public func getItineraryArray() -> [Itinerary]{
        return self.itineraries
    }

    
    func areCreatingNewItineary() -> Bool{
        return isCreatingNewItinerary
    }
    
    
    func getItineraryNameAtIndex(index: Int) -> String{
        return itineraries[index].getName()
    }
    
    
    func deleteItinerary(index: Int){
        print("DELETING: " + itineraries[index].getName())
        itineraries.removeAtIndex(index)
        notifyOfItineraryChange()
        saveItinerary()
    }
    
    
    //MARK: NSCoding
    
    func storeItineraries(){
        let isSuccessfullSave = NSKeyedArchiver.archiveRootObject(itineraries, toFile: Itinerary.ArchiveURL.path!)
        
        if !isSuccessfullSave{
            print("Could not save itineraries...")
        }
        
    }
    
    
    func loadItineraries() -> [Itinerary]?{
        print("Loading Itineratires")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Itinerary.ArchiveURL.path!) as? [Itinerary]
    }
    
    
    func notifyOfItineraryChange(){
        NSNotificationCenter.defaultCenter().postNotificationName(itinerariesListNotificationKey, object: self)
    }
    
    
}
