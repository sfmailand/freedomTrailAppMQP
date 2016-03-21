//
//  Location.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/22/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit
import OAuthSwift

public class Location: NSObject, NSCoding{
    
    //Properties
    private var name: String
    private var photo: UIImage?
    private var gpsLong: Double
    private var gpsLat: Double
    
    //Initialization
    
    init(name: String, photo: UIImage?, gpsLat: Double, gpsLong: Double){
        self.name = name
        self.photo = photo
        self.gpsLat = gpsLat
        self.gpsLong = gpsLong
    }
    
    func getName() -> String?{
        return name
    }
    
    func getPhoto() -> UIImage?{
        return photo
    }
    
    func getGpsLat() -> Double{
        return gpsLat
    }
    
    func getGpsLong() -> Double{
        return gpsLong
    }
    
    
    //MARK: NSCoding
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let gpsLongKey = "gpsLong"
        static let gpsLatKey = "gpsLat"
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(gpsLong, forKey: PropertyKey.gpsLongKey)
        aCoder.encodeObject(gpsLat, forKey: PropertyKey.gpsLatKey)
    }
    
    required convenience public init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        //let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as! UIImage
        let gpsLong = aDecoder.decodeObjectForKey(PropertyKey.gpsLongKey) as! Double
        let gpsLat = aDecoder.decodeObjectForKey(PropertyKey.gpsLatKey) as! Double
        self.init(name: name, photo: nil, gpsLat: gpsLat, gpsLong: gpsLong)
    }
    
    
    public func isLocationFinalized() -> Bool{
        return gpsLong != 0 && gpsLat != 0
    }
    
    
    public func yelpRequest(){
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
        
        oauthswift.client.get("https://api.yelp.com/v2/search/?sort=1&limit=1&category_filter=thai&ll=42.271758,-71.813496",
            success: {
                data, response in
                let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                print(dataString)
            }
            , failure: { error in
                print(error)
            }
        )
        
        
//        oauthswift.authorizeWithCallbackURL(
//            NSURL(string: "//api.yelp.com/v2/search/?location=01609&sort=1&limit=1&category_filter=pizza")!,
//            success: { credential, response, parameters in
//                print("Success")
//                print(credential.oauth_token)
//                print(credential.oauth_token_secret)
//                print(parameters["user_id"])
//            },
//            failure: { error in
//                print("ERROR")
//                print(error.localizedDescription)
//            }             
//        )
    }
    
}
