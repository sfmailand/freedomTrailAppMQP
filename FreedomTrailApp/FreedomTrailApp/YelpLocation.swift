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
    
    
    init(name: String, photoURL: String, ratingURL: String, yelpURL: String, yelpID: String, gpsLat: Double, gpsLong : Double, address: String){
        
        self.photoURL = photoURL
        self.ratingURL = ratingURL
        self.yelpURL = yelpURL
        self.yelpID = yelpID
        self.address = address
        
        
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
        self.init(name: name, photoURL: "", ratingURL: ratingURL, yelpURL: yelpURL, yelpID: yelpID, gpsLat: gpsLat, gpsLong : gpsLong, address: address)
    }
    
    
    public func yelpRequest() -> [YelpLocation]{
        
        print("Starting request")
        
        let oauthswift  = OAuth1Swift(
            consumerKey: "-KjeymOM8cXvmxhHxr2iJQ",
            consumerSecret: "mjCSrO88wwvYFfSMirQtu8i7aPw",
            requestTokenUrl: "https://www.flickr.com/services/oauth/request_token",
            authorizeUrl:    "https://www.flickr.com/services/oauth/authorize",
            accessTokenUrl:  "https://www.flickr.com/services/oauth/access_token"
        )
        
        print("Initialized auth")
        
        oauthswift.client.credential.oauth_token =  "cyYjL0ugC5-mgrp7jnQ8_QYzjTgXJGVZ"
        oauthswift.client.credential.oauth_token_secret = "hH1IMQAObbxVtCP-m02qMJ4BXuU"
        
        oauthswift.client.get("https://api.yelp.com/v2/search/?sort=1&limit=10&category_filter=thai&ll=42.271758,-71.813496",
            success: {
                data, response in
                return self.saveYelpData(data)
            }
            , failure: { error in
                print(error)
            }
        )
        return []
    }
    
    private func saveYelpData(data: NSData) -> [YelpLocation]{
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
            var yelpLocations: [YelpLocation] = []
            
            for index in 0...9{
                print("________________________")
                print("Name: " + (json["businesses"]!![index]["name"] as! String))
                print("rURL: " + (json["businesses"]!![index]["rating_img_url"] as! String))
                //print("iURL: " + (json["businesses"]!![index]["image_url"] as! String))
                print("URL: " + (json["businesses"]!![index]["url"] as! String))
                print("ID: " + (json["businesses"]!![index]["id"] as! String))
                print((json["businesses"]!![index]["location"]!!["coordinate"]!!["latitude"] as! Double))
                
                print((json["businesses"]!![index]["location"]!!["coordinate"]!!["longitude"] as! Double))
                print("Address: " + (json["businesses"]!![index]["location"]!!["display_address"]!![0] as! String) + " " + (json["businesses"]!![index]["location"]!!["display_address"]!![1] as! String))
                
                let name = (json["businesses"]!![index]["name"] as! String)
                let ratingURL = "rURL: " + (json["businesses"]!![index]["rating_img_url"] as! String)
                //let imageURL = "iURL: " + (json["businesses"]!![index]["image_url"] as! String)
                let yelpURL = "URL: " + (json["businesses"]!![index]["url"] as! String)
                let yelpID = "ID: " + (json["businesses"]!![index]["id"] as! String)
                let gpsLat = (json["businesses"]!![index]["location"]!!["coordinate"]!!["latitude"] as! Double)
                
                let gpsLong = (json["businesses"]!![index]["location"]!!["coordinate"]!!["longitude"] as! Double)
                let address = "Address: " + (json["businesses"]!![index]["location"]!!["display_address"]!![0] as! String) + " " + (json["businesses"]!![index]["location"]!!["display_address"]!![1] as! String)
                
                let tmpYelpLocation = YelpLocation(name: name, photoURL: "", ratingURL: ratingURL, yelpURL: yelpURL, yelpID: yelpID, gpsLat: gpsLat, gpsLong: gpsLong, address: address)
                
                yelpLocations.append(tmpYelpLocation)
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName(yelpLocationLoadedNotificationKey, object: self, userInfo: ["location": yelpLocations])
            return yelpLocations
        }catch{
            print("error serializing JSON: \(error)")
            return []
        }
    }
    
    
    
    
}
