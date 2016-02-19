//
//  ItineraryList.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/15/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import Foundation


protocol ItineraryViewModelDelegate{
    
    func updateView()
    
}

public class ItinerariesViewModel{
    
    //Properties
    var itineraries = [Itinerary]()
    
    var itineraryDelegate: ItineraryViewModelDelegate?
    
    
    struct PropertyKey{
        static let itinerariesKey = "itienraries"
    }
    //Initialization
    
    
    
    init?(){
        if (loadItineraries() != nil){
            itineraries = loadItineraries()!
        }
        else{
            print("No Saved Itineraries")
        }
    }
    
    func appendItinerary(itinerary: Itinerary){
        self.itineraries.append(itinerary)
        print("Appending Itinerary")
        self.itineraryDelegate?.updateView()
        saveItineraries()
    }
    
    func removeLastItinerary(){
        self.itineraries.removeLast()
    }
    
    func getCount() -> Int{
        return itineraries.count
    }
    
    func getItineraryAtIndex(index: Int) -> Itinerary{
        return itineraries[index]
    }
    
    func getLastItinerary() -> Itinerary{
        return itineraries.last!
    }
    
    func getFirstItinerary() -> Itinerary{
        return itineraries.first!
    }
    
    func printLastItineraryLocations(){
        print(itineraries.last?.locations)
    }
    
    
    //MARK: NSCoding
    
    func saveItineraries(){
        let isSuccessfullSave = NSKeyedArchiver.archiveRootObject(itineraries, toFile: Itinerary.ArchiveURL.path!)
        
        if !isSuccessfullSave{
            print("Could not save itineraries...")
        }
        
    }
    
    
    func loadItineraries() -> [Itinerary]?{
        print("Loading Itineratires")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Itinerary.ArchiveURL.path!) as? [Itinerary]
    }
    
    
}
