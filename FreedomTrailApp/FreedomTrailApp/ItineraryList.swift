//
//  ItineraryList.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/15/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//
import UIKit


public class ItineraryList {
    
    //Properties
    var itineraries = [Itinerary]()
    
    
    struct PropertyKey{
        static let itinerariesKey = "itienraries"
    }
    //Initialization
    
    
    
    init?(){

    }
    
    func appendItinerary(itinerary: Itinerary){
        self.itineraries.append(itinerary)
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
