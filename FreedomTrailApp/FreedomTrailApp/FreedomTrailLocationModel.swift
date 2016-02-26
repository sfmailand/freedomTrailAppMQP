//
//  FreedomTrailLocationModel.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/22/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import Foundation


public class FreedomTrailLocationModel{
    
    private var locations = [FreedomTrailLocation]()
    
    
    init(){
        loadLocations()
    }
    
    
    func getFullTrailLocationsArray() -> [FreedomTrailLocation]{
        return locations
    }
    
    
    func getPartialTrailLocationArray(trailIndexes: [Int]) -> [FreedomTrailLocation]{
        var locationArray: [FreedomTrailLocation]
        locationArray = []
        for index in trailIndexes{
            locationArray.append(locations[index])
        }
        
        return locationArray
    }
    
    func getLocationAtIndex(index: Int) -> Location{
        return locations[index]
    }
    
    
    func getLocationIndexes(trailLocations: [FreedomTrailLocation]) -> [Int]{
        var tmpIndexArray: [Int] = []
        for location in trailLocations{
            tmpIndexArray.append(location.getTrailLocationIndex())
        }
        
        return tmpIndexArray
        
    }
    
    
    
    func loadLocations(){
        let bostonCommonLocation = FreedomTrailLocation(name: "Boston Common", photo: nil, index: 0, gpsLat: 42.3550, gpsLong: -71.0656)
        let stateHouseLocation = FreedomTrailLocation(name: "State House", photo: nil, index: 1, gpsLat: 42.3582, gpsLong: -71.0637)
        let parkStreetChurchLocation = FreedomTrailLocation(name: "Park Street Church", photo: nil, index: 2, gpsLat: 42.3569, gpsLong: -71.0622)
        let granaryGroundLocation = FreedomTrailLocation(name: "Granary Burying Ground", photo: nil, index: 3, gpsLat: 42.3574, gpsLong: -71.0616)
        let kingChapelLocation = FreedomTrailLocation(name: "King's Chapel", photo: nil, index: 4, gpsLat: 42.358101, gpsLong: -71.060281)
        let chapelBuryingLocation = FreedomTrailLocation(name: "King's Chapel Burying Ground", photo: nil, index: 5, gpsLat: 42.3580, gpsLong: -71.0600)
        let benFranklinLocation = FreedomTrailLocation(name: "Benjamin Franklin Statue & Boston Latin School", photo: nil, index: 6, gpsLat: 42.358089, gpsLong: -71.059308)
        let oldBookStoreLocation = FreedomTrailLocation(name: "Old Corner Book Store", photo: nil, index: 7, gpsLat: 42.3575, gpsLong: -71.0589)
        let southMeetingHouseLocation = FreedomTrailLocation(name: "Old South Meeting House", photo: nil, index: 8, gpsLat: 42.3569, gpsLong: -71.0586)
        let oldStateHouseLocation = FreedomTrailLocation(name: "Old State House", photo: nil, index: 9, gpsLat: 42.3588, gpsLong: -71.0578)
        let bostonMassacreLocation = FreedomTrailLocation(name: "Site of Boston Massacre", photo: nil, index: 10, gpsLat: 42.358705, gpsLong: -71.057467)
        let fanueuilHallLocation = FreedomTrailLocation(name: "Faneuil Hall", photo: nil, index: 11, gpsLat: 42.3600, gpsLong: -71.0568)
        let paulRevereLocation = FreedomTrailLocation(name: "Paul Revere House", photo: nil, index: 12, gpsLat: 42.3637, gpsLong: -71.0537)
        let northChurchLocation = FreedomTrailLocation(name: "Old North Church", photo: nil, index: 13, gpsLat: 42.3663, gpsLong: -71.0545)
        let coppsHillLocation = FreedomTrailLocation(name: "Copp's Hill Burying Ground", photo: nil, index: 14, gpsLat: 42.3672, gpsLong: -71.0564)
        let bunkerHillLocation = FreedomTrailLocation(name: "Bunker Hill Monument", photo: nil, index: 15, gpsLat: 42.3764, gpsLong: -71.0608)
        let ussConstitutionLocation = FreedomTrailLocation(name: "USS Constitution", photo: nil, index: 16, gpsLat: 42.374143, gpsLong: -71.055610)
        
        locations += [bostonCommonLocation, stateHouseLocation, parkStreetChurchLocation, granaryGroundLocation,
            kingChapelLocation, chapelBuryingLocation, benFranklinLocation, oldBookStoreLocation,
            southMeetingHouseLocation, oldStateHouseLocation, bostonMassacreLocation, fanueuilHallLocation,
            paulRevereLocation, northChurchLocation, coppsHillLocation, bunkerHillLocation, ussConstitutionLocation]
    }
    
    
    
    
}
