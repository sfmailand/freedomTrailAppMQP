//
//  FreedomTrailLocationModel.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/22/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit


public class FreedomTrailLocationModel{
    
    private var locations = [String: FreedomTrailLocation]()
    
    
    init(){
        loadLocations()
    }
    
    
    func getFullTrailLocationsArray() -> [FreedomTrailLocation]{
        return getLocationsArray()
    }
    
    
    func getPartialTrailLocationArray(trailIndexes: [Int]) -> [FreedomTrailLocation]{
        var locationArray: [FreedomTrailLocation]
        locationArray = []
        for index in trailIndexes{
            locationArray.append(getLocationsArray()[index])
        }
        
        return locationArray
    }
    
    func getLocationAtIndex(index: Int) -> FreedomTrailLocation{
        return getLocationsArray()[index]
    }
    
    private func getLocationsArray() -> [FreedomTrailLocation]{
        return Array(locations.values)
    }

    
    
    
    func loadLocations(){
        let bostonCommonLocation = FreedomTrailLocation(name: "Boston Common", photo: UIImage(named: "boston_common"), gpsLat: 42.3550, gpsLong: -71.0656, locationDescription: bostonCommonDescription, summary: bostonCommonSummary)
        locations[bostonCommonLocation.getName()!] = bostonCommonLocation
        
        let stateHouseLocation = FreedomTrailLocation(name: "State House", photo: UIImage(named: "boston_state_house"), gpsLat: 42.3582, gpsLong: -71.0637, locationDescription: stateHouseDescription, summary: stateHouseSummary)
        locations[stateHouseLocation.getName()!] = stateHouseLocation
        
        let parkStreetChurchLocation = FreedomTrailLocation(name: "Park Street Church", photo: UIImage(named: "park_street_church"), gpsLat: 42.3569, gpsLong: -71.0622, locationDescription: parkStreetChurchDescription, summary: parkStreetChurchSummary)
        locations[parkStreetChurchLocation.getName()!] = parkStreetChurchLocation
        
        let granaryGroundLocation = FreedomTrailLocation(name: "Granary Burying Ground", photo: UIImage(named: "granary_burying_ground"), gpsLat: 42.3574, gpsLong: -71.0616, locationDescription: granaryGroundDescription, summary: granaryGroundSummary)
        locations[granaryGroundLocation.getName()!] = granaryGroundLocation
        
        let kingChapelLocation = FreedomTrailLocation(name: "King's Chapel", photo: UIImage(named: "kings_chapel"), gpsLat: 42.358101, gpsLong: -71.060281, locationDescription: kingChapelDescription, summary: kingChapelSummary)
        locations[kingChapelLocation.getName()!] = kingChapelLocation
        
        let chapelBuryingLocation = FreedomTrailLocation(name: "King's Chapel Burying Ground", photo: UIImage(named: "kings_chapel_burying_ground"), gpsLat: 42.3580, gpsLong: -71.0600, locationDescription: chapelBuryingDescription, summary: chapelBuryingSummary)
        locations[chapelBuryingLocation.getName()!] = chapelBuryingLocation
        
        let benFranklinLocation = FreedomTrailLocation(name: "Benjamin Franklin Statue & Boston Latin School", photo: UIImage(named: "ben_franklin_statue"), gpsLat: 42.358089, gpsLong: -71.059308, locationDescription: benFranklinDescription, summary: benFranklinSummary)
        locations[benFranklinLocation.getName()!] = benFranklinLocation
        
        let oldBookStoreLocation = FreedomTrailLocation(name: "Old Corner Book Store", photo: UIImage(named: "old_corner_book_store"), gpsLat: 42.3575, gpsLong: -71.0589, locationDescription: oldBookStoreDescription, summary: oldBookStoreSummary)
        locations[oldBookStoreLocation.getName()!] = oldBookStoreLocation
        
        let southMeetingHouseLocation = FreedomTrailLocation(name: "Old South Meeting House", photo: UIImage(named: "old_south_meeting_house"), gpsLat: 42.3569, gpsLong: -71.0586, locationDescription: southMeetingHouseDescription, summary: southMeetingHouseSummary)
        locations[southMeetingHouseLocation.getName()!] = southMeetingHouseLocation
        
        let oldStateHouseLocation = FreedomTrailLocation(name: "Old State House", photo: UIImage(named: "old_state_house"), gpsLat: 42.3588, gpsLong: -71.0578, locationDescription: oldStateHouseDescription, summary: oldStateHouseSummary)
        locations[oldStateHouseLocation.getName()!] = oldStateHouseLocation
        
        let bostonMassacreLocation = FreedomTrailLocation(name: "Site of Boston Massacre", photo: UIImage(named: "boston_massacre"), gpsLat: 42.358705, gpsLong: -71.057467, locationDescription: bostonMassacreDescription, summary: bostonMassacreSummary)
        locations[bostonMassacreLocation.getName()!] = bostonMassacreLocation
        
        let fanueuilHallLocation = FreedomTrailLocation(name: "Faneuil Hall", photo: UIImage(named: "faneuil_hall"), gpsLat: 42.3600, gpsLong: -71.0568, locationDescription: fanueuilHallDescription, summary: fanueuilHallSummary)
        locations[fanueuilHallLocation.getName()!] = fanueuilHallLocation
        
        let paulRevereLocation = FreedomTrailLocation(name: "Paul Revere House", photo: UIImage(named: "paul_revere_house"), gpsLat: 42.3637, gpsLong: -71.0537, locationDescription: paulRevereDescription, summary: paulRevereSummary)
        locations[paulRevereLocation.getName()!] = paulRevereLocation
        
        let northChurchLocation = FreedomTrailLocation(name: "Old North Church", photo: UIImage(named: "old_north_church"), gpsLat: 42.3663, gpsLong: -71.0545, locationDescription: northChurchDescription, summary: northChurchSummary)
        locations[northChurchLocation.getName()!] = northChurchLocation
        
        let coppsHillLocation = FreedomTrailLocation(name: "Copp's Hill Burying Ground", photo: UIImage(named: "copps_hill_burying_ground"), gpsLat: 42.3672, gpsLong: -71.0564, locationDescription: coppsHillDescription, summary: coppsHillSummary)
        locations[coppsHillLocation.getName()!] = coppsHillLocation
        
        let bunkerHillLocation = FreedomTrailLocation(name: "Bunker Hill Monument", photo: UIImage(named: "bunker_hill"), gpsLat: 42.3764, gpsLong: -71.0608, locationDescription: bunkerHillDescription, summary: bunkerHillSummary)
        locations[bunkerHillLocation.getName()!] = bunkerHillLocation
        
        let ussConstitutionLocation = FreedomTrailLocation(name: "USS Constitution", photo: UIImage(named: "uss_constitution"), gpsLat: 42.374143, gpsLong: -71.055610, locationDescription: ussConstitutionDescription, summary: ussConstitutionSummary)
        locations[ussConstitutionLocation.getName()!] = ussConstitutionLocation
    }
    
    
    
    
}
