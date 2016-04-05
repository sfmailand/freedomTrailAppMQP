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
        static let ratingKey = "rating"
        static let yelpURLKey = "yelpURL"
        static let yelpIDKey = "yelpID"
        static let addressKey = "yelpAddress"
        static let photoURLKey = "photoURL"
        static let reviewCountKey = "reviewConut"
    }
    
    var photoURL: String!
    var rating: Double!
    var yelpURL: String!
    var yelpID: String!
    var address: String!
    var isClosed: Bool!
    var reviewCount: Int!
    
    private var yelpFilters = YelpFilters()
    
    
    init(name: String, photoURL: String, rating: Double, reviewCount: Int, yelpURL: String, yelpID: String, gpsLat: Double, gpsLong : Double, address: String, isClosed: Bool, description: String, summary: String, arrivalTime: NSDate){
        
        self.photoURL = photoURL
        self.rating = rating
        self.yelpURL = yelpURL
        self.yelpID = yelpID
        self.address = address
        self.isClosed = isClosed
        self.reviewCount = reviewCount
        
        
        super.init(name: name, photo: nil, gpsLat: gpsLat, gpsLong: gpsLong, locationDescription: description, summary: summary, arrivalTime: arrivalTime)
        
    }
    
    init(name: String, photoURL: String, rating: Double, reviewCount: Int, yelpURL: String, yelpID: String, gpsLat: Double, gpsLong : Double, address: String, isClosed: Bool, description: String, summary: String, arrivalTime: NSDate, photo: UIImage){
        
        self.photoURL = photoURL
        self.rating = rating
        self.yelpURL = yelpURL
        self.yelpID = yelpID
        self.address = address
        self.isClosed = isClosed
        self.reviewCount = reviewCount
        
        
        super.init(name: name, photo: photo, gpsLat: gpsLat, gpsLong: gpsLong, locationDescription: description, summary: summary, arrivalTime: arrivalTime)
        
    }
    
    init(name: String, photoURL: String, rating: Double, reviewCount: Int, yelpURL: String, yelpID: String, gpsLat: Double, gpsLong : Double, address: String, isClosed: Bool, description: String, summary: String){
        
        self.photoURL = photoURL
        self.rating = rating
        self.yelpURL = yelpURL
        self.yelpID = yelpID
        self.address = address
        self.isClosed = isClosed
        self.reviewCount = reviewCount
        
        
        super.init(name: name, photo: nil, gpsLat: gpsLat, gpsLong: gpsLong, locationDescription: description, summary: summary, arrivalTime: NSDate(timeIntervalSince1970: 0))
        
    }
    
    
    public override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(photoURL, forKey: PropertyKey.photoURLKey)
        aCoder.encodeObject(rating, forKey: PropertyKey.ratingKey)
        aCoder.encodeObject(yelpURL, forKey: PropertyKey.yelpURLKey)
        aCoder.encodeObject(yelpID, forKey: PropertyKey.yelpIDKey)
        aCoder.encodeObject(address, forKey: PropertyKey.addressKey)
        aCoder.encodeObject(reviewCount, forKey: PropertyKey.reviewCountKey)
        
    }
    
    
    
    required convenience public init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photoURL = aDecoder.decodeObjectForKey(PropertyKey.photoURLKey) as! String
        let rating = aDecoder.decodeObjectForKey(PropertyKey.ratingKey) as! Double
        let reviewCount = aDecoder.decodeObjectForKey(PropertyKey.reviewCountKey) as! Int
        let yelpURL = aDecoder.decodeObjectForKey(PropertyKey.yelpURLKey) as! String
        let yelpID = aDecoder.decodeObjectForKey(PropertyKey.yelpIDKey) as! String
        let gpsLong = aDecoder.decodeObjectForKey(PropertyKey.gpsLongKey) as! Double
        let gpsLat = aDecoder.decodeObjectForKey(PropertyKey.gpsLatKey) as! Double
        let address = aDecoder.decodeObjectForKey(PropertyKey.addressKey) as! String
        let summary = aDecoder.decodeObjectForKey(PropertyKey.summaryKey) as! String
        let description = aDecoder.decodeObjectForKey(PropertyKey.descriptionKey) as! String
        let arrivalTime = aDecoder.decodeObjectForKey(PropertyKey.arrivalTimeKey) as! NSDate
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as! UIImage
        
        
        self.init(name: name, photoURL: photoURL, rating: rating, reviewCount: reviewCount, yelpURL: yelpURL, yelpID: yelpID, gpsLat: gpsLat, gpsLong : gpsLong, address: address, isClosed: false, description: description, summary: summary, arrivalTime: arrivalTime, photo: photo)
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
        
        
        var yelpRequestURL = "https://api.yelp.com/v2/search/?sort=1&limit=20&category_filter="
        yelpRequestURL += (yelpFilters.getRestaurantIdentifierByType(getName()!))
        yelpRequestURL += "&&ll="+String(format:"%f", nearbyLocation.getGpsLat()) + ","
        yelpRequestURL += String(format:"%f", nearbyLocation.getGpsLong())
        
        print(yelpRequestURL)
        
        oauthswift.client.get("https://api.yelp.com/v2/search/?sort=1&limit=20&category_filter="+yelpFilters.getRestaurantIdentifierByType(getName()!)+"&ll="+String(format:"%f", nearbyLocation.getGpsLat()) + ","+String(format:"%f", nearbyLocation.getGpsLong()),
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
                var hasImageURL = false
                let name = (json["businesses"]!![index]["name"] as! String)
                let rating = (json["businesses"]!![index]["rating"] as! Double)
                let reviewCount = (json["businesses"]!![index]["review_count"] as! Int)
                if let tmpPhotoURL = (json["businesses"]!![index]["image_url"]){
                    photoURL = tmpPhotoURL as! String
                    hasImageURL = true
                }
                let yelpURL = (json["businesses"]!![index]["url"] as! String)
                let yelpID = (json["businesses"]!![index]["id"] as! String)
                let gpsLat = (json["businesses"]!![index]["location"]!!["coordinate"]!!["latitude"] as! Double)
                let gpsLong = (json["businesses"]!![index]["location"]!!["coordinate"]!!["longitude"] as! Double)
                let address = ((json["businesses"]!![index]["location"]!!["display_address"] as! NSArray)[0] as! String) + " " + ((json["businesses"]!![index]["location"]!!["display_address"] as! NSArray)[1] as! String)
                let summary = (json["businesses"]!![index]["snippet_text"] as! String)
                
                //TODO: Add reviews as the description
                let description = (json["businesses"]!![index]["snippet_text"] as! String)
                
                let isClosedResults = (json["businesses"]!![index]["is_closed"] as! Bool)
                let tmpYelpLocation = YelpLocation(name: name, photoURL: photoURL, rating: rating, reviewCount: reviewCount, yelpURL: yelpURL, yelpID: yelpID, gpsLat: gpsLat, gpsLong: gpsLong, address: address, isClosed: isClosedResults, description: description, summary: "")
                
                if(hasImageURL == true){
                    downloadImage(NSURL(string: photoURL)!, location: tmpYelpLocation)
                }
                else{
                    tmpYelpLocation.setPhoto(UIImage(named: "no_image")!)
                }
                
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
    
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL, location: YelpLocation){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                location.setPhoto(UIImage(data: data)!)
            }
        }
    }
    
    
    
    
}
