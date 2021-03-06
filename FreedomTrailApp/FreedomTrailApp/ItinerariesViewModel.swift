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
    
    func createNewItinerary(){
        let tempItinerary = Itinerary(name: "Untitled Itinerary", itineraryDescription: "No Description")
        itineraries.append(tempItinerary!)
        selectedItineraryIndex = itineraries.count - 1
        isCreatingNewItinerary = true
    }
    
    
    func cancelItineraryCreation(){
        if(isCreatingNewItinerary == true){
            print("Canceling Itinerary Creation")
            itineraries.removeLast()
            isCreatingNewItinerary = false
        }
    }
    
    
    func saveItinerary(){
        print("SAVING")
        print(itineraries.count)
        notifyOfItineraryChange()
        storeItineraries()
        isCreatingNewItinerary = false
    }
    
    
    func getCount() -> Int{
        return itineraries.count
    }
    
    func getNumberOfLocations() -> Int{
        return itineraries[selectedItineraryIndex].getNumberOfLocations()
    }
    
    
    
    
    
    
    //For temparary itinerary when creating a new one

    
    func addLocationToItinerary(location: Location){
        itineraries[selectedItineraryIndex].addLocation(location)
    }
    
    func changeItineraryName(name: String){
        itineraries[selectedItineraryIndex].setName(name)
    }
    
    func getStartTime() -> NSDate{
        return itineraries[selectedItineraryIndex].getStartTime()
    }
    
    func setStartTime(startTime: NSDate){
        itineraries[selectedItineraryIndex].setStartTime(startTime)
    }
    
    func setCurrentItinerary(index: Int){
        selectedItineraryIndex = index
    }
    
    
    func getCurrentItinerary() -> Itinerary{
        return itineraries[selectedItineraryIndex]
    }
    
    func setSelectedLocationIndex(index: Int){
        selectedLocationIndexAtSelectedItinerary = index
    }
    
    public func getCurrentLocation() -> Location{
        return itineraries[selectedItineraryIndex].getLocationAtIndex(selectedLocationIndexAtSelectedItinerary)
    }
    
    public func getPreviousLocation() -> Location{
        var returnLocation = itineraries[selectedItineraryIndex].getLocationAtIndex(selectedLocationIndexAtSelectedItinerary)
        if(selectedLocationIndexAtSelectedItinerary != 0){
            returnLocation = itineraries[selectedItineraryIndex].getLocationAtIndex(selectedLocationIndexAtSelectedItinerary - 1)
            selectedLocationIndexAtSelectedItinerary = selectedLocationIndexAtSelectedItinerary - 1
        }
        return returnLocation
    }
    
    public func getNextLocation() -> Location{
        var returnLocation = itineraries[selectedItineraryIndex].getLocationAtIndex(selectedLocationIndexAtSelectedItinerary)
        if(selectedLocationIndexAtSelectedItinerary < itineraries[selectedItineraryIndex].getLocations().count - 1){
            returnLocation = itineraries[selectedItineraryIndex].getLocationAtIndex(selectedLocationIndexAtSelectedItinerary + 1)
            selectedLocationIndexAtSelectedItinerary = selectedLocationIndexAtSelectedItinerary + 1
        }
        return returnLocation
    }
    
    
    public func getNearbyLocation() -> Location{

        
        if(selectedLocationIndexAtSelectedItinerary == 0){
            if(itineraries[selectedItineraryIndex].getNumberOfLocations() == 1){
                print("From Boston -- Saved")
                return Location(name: "Boston", photo: nil, gpsLat: 42.3551, gpsLong: -71.0656, locationDescription: "", summary: "")
            }
            print("Getting location of next stop")
            return getNextLocation()
            
        }
        return getPreviousLocation()
    }
    
    

    
    
    public func getAllLocationsInItinerary() -> [Location]{
        return itineraries[selectedItineraryIndex].getLocations()
    }
    
    public func endItineraryCreation(){
        isCreatingNewItinerary = false
    }
    
    
    public func getItineraryArray() -> [Itinerary]{
        return self.itineraries
    }

    
    func isCreatingNewItineary() -> Bool{
        return isCreatingNewItinerary
    }
    
    
    func getItineraryNameAtIndex(index: Int) -> String{
        return itineraries[index].getName()
    }
    
    
    func deleteItinerary(index: Int){
        print("DELETING: ")
        print(itineraries.count)
        itineraries.removeAtIndex(index)
        notifyOfItineraryChange()
        saveItinerary()
    }
    
    func finalizeYelpLocation(location: YelpLocation){
        print("Finalize")
        print("Location Index: " + String(selectedLocationIndexAtSelectedItinerary))
        itineraries[selectedItineraryIndex].setLocationAtIndex(selectedLocationIndexAtSelectedItinerary, location: location)
    }
    
    
    public func getNearbyLocation(selectedIndex: Int) -> Location{
        print(selectedIndex)
        if(selectedIndex + 1 > itineraries[selectedItineraryIndex].getNumberOfLocations()
            || selectedIndex - 1 < 0){
            return Location(name: "Boston", photo: nil, gpsLat: 42.3551, gpsLong: -71.0656, locationDescription: "", summary: "")
        }
        
        else if(selectedIndex == 0){
            if(itineraries[selectedItineraryIndex].getNumberOfLocations() == 1){
                print("From Boston -- Saved")
                return Location(name: "Boston", photo: nil, gpsLat: 42.3551, gpsLong: -71.0656, locationDescription: "", summary: "")
            }
            print("Getting location of next stop")
            if(getNextLocation(selectedIndex).isLocationFinalized() == true){
                return getNextLocation(selectedIndex)
            }
            
        }
        if(getPreviousLocation(selectedIndex).isLocationFinalized() == true){
            return getPreviousLocation(selectedIndex)
        }
        
        return Location(name: "Boston", photo: nil, gpsLat: 42.3551, gpsLong: -71.0656, locationDescription: "", summary: "")
    }
    
    public func getPreviousLocation(selectedIndex: Int) -> Location{
        if(selectedIndex == 0){
            return itineraries[selectedItineraryIndex].getLocationAtIndex(selectedIndex - 1)
        }
        return itineraries[selectedItineraryIndex].getLocationAtIndex(selectedIndex - 1)
    }
    
    public func getNextLocation(selectedIndex: Int) -> Location{
        if(selectedIndex >= itineraries[selectedItineraryIndex].getNumberOfLocations() - 1){
            return itineraries[selectedItineraryIndex].getLocationAtIndex(selectedIndex)
        }
        return itineraries[selectedItineraryIndex].getLocationAtIndex(selectedIndex + 1)
    }
    
    
    public func swapLocations(newIndex: Int, oldIndex: Int){
        itineraries[selectedItineraryIndex].swapLocations(newIndex, oldIndex: oldIndex)
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
        print("Itinerary Changed - Notification")
        NSNotificationCenter.defaultCenter().postNotificationName(itinerariesListNotificationKey, object: self)
    }
    
    
    func setArrivalTime(locationIndex: Int, arrivalTime: NSDate){
        itineraries[selectedItineraryIndex].getLocationAtIndex(locationIndex).setArrivalTime(arrivalTime)
    }
    
    
}
