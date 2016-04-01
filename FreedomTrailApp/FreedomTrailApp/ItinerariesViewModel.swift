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
    private var selectedLocationIndexAtSelectedItinerary: Int!
    
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
        }
    }
    
    func saveItinerary(){
        if(isCreatingNewItinerary == true){
            self.itineraries.append(tempItinerary)
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
    
    func setSelectedLocationIndex(index: Int){
        selectedLocationIndexAtSelectedItinerary = index
    }
    
    public func getCurrentLocation() -> Location{
        if(isCreatingNewItinerary == true){
            return tempItinerary.getLocationAtIndex(selectedLocationIndexAtSelectedItinerary)
        }
        return itineraries[selectedItineraryIndex].getLocationAtIndex(selectedLocationIndexAtSelectedItinerary)
    }
    
    public func getPreviousLocation() -> Location{
        if(isCreatingNewItinerary == true){
            return tempItinerary.getLocationAtIndex(selectedLocationIndexAtSelectedItinerary - 1)
        }
        return itineraries[selectedItineraryIndex].getLocationAtIndex(selectedLocationIndexAtSelectedItinerary - 1)
    }
    
    public func getNextLocation() -> Location{
        if(isCreatingNewItinerary == true){
            return tempItinerary.getLocationAtIndex(selectedLocationIndexAtSelectedItinerary + 1)
        }
        return itineraries[selectedItineraryIndex].getLocationAtIndex(selectedLocationIndexAtSelectedItinerary + 1)
    }
    
    
    public func getNearbyLocation() -> Location{

        
        if(selectedLocationIndexAtSelectedItinerary == 0){
            if(isCreatingNewItinerary == true){
                if(tempItinerary.getNumberOfLocations() == 1){
                    print("From Boston -- Temp")
                    return Location(name: "Boston", photo: nil, gpsLat: 42.3551, gpsLong: -71.0656)
                }
            }
            else if(itineraries[selectedItineraryIndex].getNumberOfLocations() == 1){
                print("From Boston -- Saved")
                return Location(name: "Boston", photo: nil, gpsLat: 42.3551, gpsLong: -71.0656)
            }
            print("Getting location of next stop")
            return getNextLocation()
            
        }
        print("Get previous location")
        return getPreviousLocation()
    }
    
    
    
    public func getAllLocationsInItinerary() -> [Location]{
        return itineraries[selectedItineraryIndex].getLocations()
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
        itineraries.removeAtIndex(index)
        notifyOfItineraryChange()
        saveItinerary()
    }
    
    func finalizeYelpLocation(location: YelpLocation){
        if(isCreatingNewItinerary == true){
            tempItinerary.setLocationAtIndex(selectedLocationIndexAtSelectedItinerary, location: location)
        }
        else{
            itineraries[selectedItineraryIndex].setLocationAtIndex(selectedLocationIndexAtSelectedItinerary, location: location)
        }
    }
    
    
    public func getNearbyLocation(selectedIndex: Int) -> Location{
        print(selectedIndex)
        if(selectedIndex + 1 > itineraries[selectedItineraryIndex].getNumberOfLocations()
            || selectedIndex - 1 < 0){
            return Location(name: "Boston", photo: nil, gpsLat: 42.3551, gpsLong: -71.0656)
        }
        
        else if(selectedIndex == 0){
            if(isCreatingNewItinerary == true){
                if(tempItinerary.getNumberOfLocations() == 0){
                    print("From Boston -- Temp")
                    return Location(name: "Boston", photo: nil, gpsLat: 42.3551, gpsLong: -71.0656)
                }
            }
            else if(itineraries[selectedItineraryIndex].getNumberOfLocations() == 1){
                print("From Boston -- Saved")
                return Location(name: "Boston", photo: nil, gpsLat: 42.3551, gpsLong: -71.0656)
            }
            print("Getting location of next stop")
            if(getNextLocation(selectedIndex).isLocationFinalized() == true){
                return getNextLocation(selectedIndex)
            }
            
        }
        print("Get previous location")
        if(getPreviousLocation(selectedIndex).isLocationFinalized() == true){
            return getPreviousLocation(selectedIndex)
        }
        
        return Location(name: "Boston", photo: nil, gpsLat: 42.3551, gpsLong: -71.0656)
    }
    
    public func getPreviousLocation(selectedIndex: Int) -> Location{
        if(isCreatingNewItinerary == true){
            return tempItinerary.getLocationAtIndex(selectedIndex - 1)
        }
        return itineraries[selectedItineraryIndex].getLocationAtIndex(selectedIndex - 1)
    }
    
    public func getNextLocation(selectedIndex: Int) -> Location{
        if(isCreatingNewItinerary == true){
            return tempItinerary.getLocationAtIndex(selectedIndex + 1)
        }
        return itineraries[selectedItineraryIndex].getLocationAtIndex(selectedIndex + 1)
    }
    
    
    //MARK: NSCoding
    
    func storeItineraries(){
        let isSuccessfullSave = NSKeyedArchiver.archiveRootObject(itineraries, toFile: Itinerary.ArchiveURL.path!)
        
        if !isSuccessfullSave{
        }
        
    }
    
    
    func loadItineraries() -> [Itinerary]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Itinerary.ArchiveURL.path!) as? [Itinerary]
    }
    
    
    func notifyOfItineraryChange(){
        NSNotificationCenter.defaultCenter().postNotificationName(itinerariesListNotificationKey, object: self)
    }
    
    
}
