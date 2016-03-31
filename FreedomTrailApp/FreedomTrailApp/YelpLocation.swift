//
//  YelpLocation.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 3/20/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import Foundation
import UIKit
import OAuthSwift


public class YelpLocation: Location {
    
    //Initialization
    
    struct PropertyKey {
        static let ratingKey = "ratingURL"
        static let yelpURLKey = "yelpURL"
        static let yelpIDKey = "yelpID"
        static let addressKey = "yelpAddress"
        static let photoURLKey = "photoURL"
    }
    
    var photoURL: String!
    var ratingURL: String!
    var yelpURL: String!
    var yelpID: String!
    var address: String!
    var isClosed: Bool!
    
    private var yelpFilters = YelpFilters()
    
    
    init(name: String, photoURL: String, ratingURL: String, yelpURL: String, yelpID: String, gpsLat: Double, gpsLong : Double, address: String, isClosed: Bool){
        
        self.photoURL = photoURL
        self.ratingURL = ratingURL
        self.yelpURL = yelpURL
        self.yelpID = yelpID
        self.address = address
        self.isClosed = isClosed
        
        
        super.init(name: name, photo: nil, gpsLat: gpsLat, gpsLong: gpsLong)
        
    }
    
    
    public override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(photoURL, forKey: PropertyKey.photoURLKey)
        aCoder.encodeObject(ratingURL, forKey: PropertyKey.ratingKey)
        aCoder.encodeObject(yelpURL, forKey: PropertyKey.yelpURLKey)
        aCoder.encodeObject(yelpID, forKey: PropertyKey.yelpIDKey)
        aCoder.encodeObject(address, forKey: PropertyKey.addressKey)
    }
    
    
    
    required convenience public init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        //let photoURL = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as! String
        let ratingURL = aDecoder.decodeObjectForKey(PropertyKey.ratingKey) as! String
        let yelpURL = aDecoder.decodeObjectForKey(PropertyKey.yelpURLKey) as! String
        let yelpID = aDecoder.decodeObjectForKey(PropertyKey.yelpIDKey) as! String
        let gpsLong = aDecoder.decodeObjectForKey(PropertyKey.gpsLongKey) as! Double
        let gpsLat = aDecoder.decodeObjectForKey(PropertyKey.gpsLatKey) as! Double
        let address = aDecoder.decodeObjectForKey(PropertyKey.addressKey) as! String
        self.init(name: name, photoURL: "", ratingURL: ratingURL, yelpURL: yelpURL, yelpID: yelpID, gpsLat: gpsLat, gpsLong : gpsLong, address: address, isClosed: false)
    }
    
    
    public func yelpRequest(nearbyLocation: Location){
        
        let oauthswift  = OAuth1Swift(
            consumerKey: "-KjeymOM8cXvmxhHxr2iJQ",
            consumerSecret: "mjCSrO88wwvYFfSMirQtu8i7aPw",
            requestTokenUrl: "https://www.flickr.com/services/oauth/request_token",
            authorizeUrl:    "https://www.flickr.com/services/oauth/authorize",
            accessTokenUrl:  "https://www.flickr.com/services/oauth/access_token"
        )
        
        
        oauthswift.client.credential.oauth_token =  "cyYjL0ugC5-mgrp7jnQ8_QYzjTgXJGVZ"
        oauthswift.client.credential.oauth_token_secret = "hH1IMQAObbxVtCP-m02qMJ4BXuU"
        
        
        var yelpRequestURL = "https://api.yelp.com/v2/search/?sort=1&limit=10&category_filter="
        yelpRequestURL += (yelpFilters.getRestaurantIdentifierByType(getName()!))
        yelpRequestURL += "&&ll="+String(format:"%f", nearbyLocation.getGpsLat()) + ","
        yelpRequestURL += String(format:"%f", nearbyLocation.getGpsLong())
        
        print(yelpRequestURL)
        
        oauthswift.client.get("https://api.yelp.com/v2/search/?sort=1&limit=10&category_filter="+yelpFilters.getRestaurantIdentifierByType(getName()!)+"&ll="+String(format:"%f", nearbyLocation.getGpsLat()) + ","+String(format:"%f", nearbyLocation.getGpsLong()),
            success: {
                data, response in
                return self.saveYelpData(data)
            }
            , failure: { error in
                print(error)
            }
        )
    }
    
    private func saveYelpData(data: NSData){
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
            var yelpLocations: [YelpLocation] = []
            
            var numResults = json["total"] as! Int
            
            if(numResults > 10){
                numResults = 10
            }
            
            for index in 0...numResults-1{
                let name = (json["businesses"]!![index]["name"] as! String)
                let ratingURL = (json["businesses"]!![index]["rating_img_url"] as! String)
                //let imageURL = "iURL: " + (json["businesses"]!![index]["image_url"] as! String)
                let yelpURL = (json["businesses"]!![index]["url"] as! String)
                let yelpID = (json["businesses"]!![index]["id"] as! String)
                let gpsLat = (json["businesses"]!![index]["location"]!!["coordinate"]!!["latitude"] as! Double)
                let gpsLong = (json["businesses"]!![index]["location"]!!["coordinate"]!!["longitude"] as! Double)
                let address = ((json["businesses"]!![index]["location"]!!["display_address"] as! NSArray)[0] as! String) + " " + ((json["businesses"]!![index]["location"]!!["display_address"] as! NSArray)[1] as! String)
                
                let isClosedResults = (json["businesses"]!![index]["is_closed"] as! Bool)
                let tmpYelpLocation = YelpLocation(name: name, photoURL: "", ratingURL: ratingURL, yelpURL: yelpURL, yelpID: yelpID, gpsLat: gpsLat, gpsLong: gpsLong, address: address, isClosed: isClosedResults)
                
                yelpLocations.append(tmpYelpLocation)
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName(yelpLocationLoadedNotificationKey, object: self, userInfo: ["location": yelpLocations])
        }catch{
            print("error serializing JSON: \(error)")
        }
    }
    
    
    private func getYelpLocationTypeString() -> String{
        return ""
    }
    
    
    
    
}
