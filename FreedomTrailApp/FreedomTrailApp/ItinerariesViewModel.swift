//
//  ItineraryList.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/15/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//


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
    }
    
    func appendItinerary(itinerary: Itinerary){
        self.itineraries.append(itinerary)
        print("Appending Itinerary")
        self.itineraryDelegate?.updateView()
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
    
    
}
