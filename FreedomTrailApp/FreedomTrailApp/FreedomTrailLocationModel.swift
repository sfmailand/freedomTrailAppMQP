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
    
    
    func loadLocations(){
        let bostonCommonLocation = FreedomTrailLocation(name: "Boston Common", photo: nil, index: 0)
        let stateHouseLocation = FreedomTrailLocation(name: "State House", photo: nil, index: 1)
        let parkStreetChurchLocation = FreedomTrailLocation(name: "Park Street Church", photo: nil, index: 2)
        let granaryGroundLocation = FreedomTrailLocation(name: "Granary Burying Ground", photo: nil, index: 3)
        let kingChapelLocation = FreedomTrailLocation(name: "King's Chapel", photo: nil, index: 4)
        let chapelBuryingLocation = FreedomTrailLocation(name: "King's Chapel Burying Ground", photo: nil, index: 5)
        let benFranklinLocation = FreedomTrailLocation(name: "Benjamin Franklin Statue & Boston Latin School", photo: nil, index: 6)
        let oldBookStoreLocation = FreedomTrailLocation(name: "Old Corner Book Store", photo: nil, index: 7)
        let southMeetingHouseLocation = FreedomTrailLocation(name: "Old South Meeting House", photo: nil, index: 8)
        let oldStateHouseLocation = FreedomTrailLocation(name: "Old State House", photo: nil, index: 9)
        let bostonMassacreLocation = FreedomTrailLocation(name: "Site of Boston Massacre", photo: nil, index: 10)
        let fanueuilHallLocation = FreedomTrailLocation(name: "Faneuil Hall", photo: nil, index: 11)
        let paulRevereLocation = FreedomTrailLocation(name: "Paul Revere House", photo: nil, index: 12)
        let northChurchLocation = FreedomTrailLocation(name: "Old North Church", photo: nil, index: 13)
        let coppsHillLocation = FreedomTrailLocation(name: "Copp's Hill Burying Ground", photo: nil, index: 14)
        let bunkerHillLocation = FreedomTrailLocation(name: "Bunker Hill Monument", photo: nil, index: 15)
        let ussConstitutionLocation = FreedomTrailLocation(name: "USS Constitution", photo: nil, index: 16)
        
        locations += [bostonCommonLocation, stateHouseLocation, parkStreetChurchLocation, granaryGroundLocation,
                               kingChapelLocation, chapelBuryingLocation, benFranklinLocation, oldBookStoreLocation,
                               southMeetingHouseLocation, oldStateHouseLocation, bostonMassacreLocation, fanueuilHallLocation,
                               paulRevereLocation, northChurchLocation, coppsHillLocation, bunkerHillLocation, ussConstitutionLocation]
    }
    
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
    
    
    
    
}
