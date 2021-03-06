//
//  Location.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/22/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

public class Location: NSObject, NSCoding{
    
    //Properties
    private var name: String
    private var photo: UIImage?
    private var gpsLong: Double
    private var gpsLat: Double
    private var summary: String
    private var locationDescription: String
    private var arrivalTime: NSDate
    
    public var numSecondsToHere: Double?
    
    //Initialization
    
    init(name: String, photo: UIImage?, gpsLat: Double, gpsLong: Double, locationDescription: String, summary: String, arrivalTime: NSDate){
        self.name = name
        self.photo = photo
        self.gpsLat = gpsLat
        self.gpsLong = gpsLong
        self.locationDescription = locationDescription
        self.summary = summary
        self.arrivalTime = arrivalTime
    }
    
    init(name: String, photo: UIImage?, gpsLat: Double, gpsLong: Double, locationDescription: String, summary: String){
        self.name = name
        self.photo = photo
        self.gpsLat = gpsLat
        self.gpsLong = gpsLong
        self.locationDescription = locationDescription
        self.summary = summary
        self.arrivalTime = NSDate(timeIntervalSince1970: 0)
    }
    
    func getName() -> String?{
        return name
    }
    
    func getPhoto() -> UIImage?{
        return photo
    }
    
    func setPhoto(photo: UIImage){
        self.photo = photo
        print("PHOTO SET")
    }
    
    func getGpsLat() -> Double{
        return gpsLat
    }
    
    func getGpsLong() -> Double{
        return gpsLong
    }
    
    func getSummary() -> String{
        return summary
    }
    
    func getDescription() -> String{
        return locationDescription 
    }
    
    func setArrivalTime(arrivalTime: NSDate){
        self.arrivalTime = arrivalTime
    }
    
    func getArrivalTime() -> NSDate{
        return arrivalTime
    }
    
    
    //MARK: NSCoding
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let gpsLongKey = "gpsLong"
        static let gpsLatKey = "gpsLat"
        static let summaryKey = "summary"
        static let descriptionKey = "description"
        static let arrivalTimeKey = "arrivalTime"
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(gpsLong, forKey: PropertyKey.gpsLongKey)
        aCoder.encodeObject(gpsLat, forKey: PropertyKey.gpsLatKey)
        aCoder.encodeObject(summary, forKey: PropertyKey.summaryKey)
        aCoder.encodeObject(locationDescription, forKey: PropertyKey.descriptionKey)
        aCoder.encodeObject(arrivalTime, forKey: PropertyKey.arrivalTimeKey)
    }
    
    required convenience public init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let summary = aDecoder.decodeObjectForKey(PropertyKey.summaryKey) as! String
        let description = aDecoder.decodeObjectForKey(PropertyKey.descriptionKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as! UIImage
        let gpsLong = aDecoder.decodeObjectForKey(PropertyKey.gpsLongKey) as! Double
        let gpsLat = aDecoder.decodeObjectForKey(PropertyKey.gpsLatKey) as! Double
        let arrivalTime = aDecoder.decodeObjectForKey(PropertyKey.arrivalTimeKey) as! NSDate
        self.init(name: name, photo: photo, gpsLat: gpsLat, gpsLong: gpsLong, locationDescription: description, summary: summary, arrivalTime: arrivalTime)
    }
    
    
    public func isLocationFinalized() -> Bool{
        return gpsLong != 0 && gpsLat != 0
    }
    
    
    
}
