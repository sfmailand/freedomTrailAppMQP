//
//  httpRequest.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 4/4/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import Foundation


public class HttpRequest{
    
    var itineraryModel: ItinerariesViewModel!
    
    var startTime: NSDate!
    
    
    init?(itineraryModel: ItinerariesViewModel){
        self.itineraryModel = itineraryModel
    }
    
    public func getArrivalTimeRequest(){
        startTime = itineraryModel.getStartTime()
        let numLocations = itineraryModel.getNumberOfLocations() - 1
        let locations = itineraryModel.getAllLocationsInItinerary()
        
        if(numLocations >= 0){
            for index in 0...numLocations{
                var previousGpsLat: Double = 0
                var previousGpsLong: Double = 0
                let currentGpsLat = locations[index].getGpsLat()
                let currentGpsLong = locations[index].getGpsLong()
                let isLocationFinalize = locations[index].isLocationFinalized()
                
                
                if(index == 0){
                    previousGpsLat = currentGpsLat
                    previousGpsLong = currentGpsLong
                }
                else{
                    var minusIndex = 1
                    var loop = true
                    while(loop == true){
                        if(locations[index-minusIndex].isLocationFinalized() == true){
                            previousGpsLat = locations[index - minusIndex].getGpsLat()
                            previousGpsLong = locations[index - minusIndex].getGpsLong()
                            loop = false
                        }
                        else if(index - minusIndex == 0){
                            previousGpsLat = currentGpsLat
                            previousGpsLong = currentGpsLong
                            loop = false
                        }
                        minusIndex += 1
                    }
                }
                
                var requestURL = "https://maps.googleapis.com/maps/api/directions/json?"
                requestURL += "origin=" + String(format:"%f", (previousGpsLat)) + "," + String(format:"%f", (previousGpsLong)) //"42.3550,-71.0656"
                requestURL += "&destination=" + String(format:"%f", currentGpsLat) + "," + String(format:"%f", currentGpsLong)
                requestURL += "&mode=walking&key=AIzaSyDFN9FlWd3FzLGOF3oEyp98o-TGDwLLd0s"
                
                if(isLocationFinalize == true){
                    getRequest(requestURL, index: index)
                }
                
                
            }

        }
    }
    
    
    public func getRequest(requestString: String, index: Int){
        //print("GET REQUEST: " + requestString)
        
        
        // Send HTTP GET Request
        
        // Create NSURL Ibject
        let myUrl = NSURL(string: requestString);
        
        // Creaste URL Request
        let request = NSMutableURLRequest(URL:myUrl!);
        
        // Set request HTTP method to GET. It could be POST as well
        request.HTTPMethod = "GET"


        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            

            // Convert server json response to NSDictionary
            do {
                if let convertedJson = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {

                    //TODO Update Location Arrival Times
                    self.itineraryModel.getAllLocationsInItinerary()[index].numSecondsToHere = (convertedJson["routes"]![0]["legs"]!![0]["duration"]!!["value"]) as? Double
                    if(index == self.itineraryModel.getAllLocationsInItinerary().count - 1){
                        print("HERE")
                        
                        var initialTime = NSDate(timeIntervalSince1970: self.itineraryModel.getStartTime().timeIntervalSince1970)
                        
                        for locationIndex in 0...self.itineraryModel.getAllLocationsInItinerary().count - 1{
                            let location = self.itineraryModel.getAllLocationsInItinerary()[locationIndex]
                            print(initialTime)
                            
                            if(location.isLocationFinalized() == true){
                                location.setArrivalTime(NSDate(timeIntervalSince1970: initialTime.timeIntervalSince1970 + location.numSecondsToHere!))
                                initialTime = location.getArrivalTime()

                            }
                            
                        }
                        print("Finished all HTTP Requests - Notification")
                        NSNotificationCenter.defaultCenter().postNotificationName(completedArrivalTimeGetRequest, object: self)
                    }
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        

        
    }
}





//            itineraryModel?.setArrivalTime(indexPath.row, arrivalTime: arrivalTimeReference)
//
//            cell.arrivalTimeLabel.text = "Arrival: ~" + self.timeFormatter.stringFromDate((location?.getArrivalTime())!)
//
//
//            let nextLocation = itineraryModel?.getNextLocation(indexPath.row)
//
//            if(nextLocation?.isLocationFinalized() == true){
//                var requestURL = "https://maps.googleapis.com/maps/api/directions/json?"
//                requestURL += "origin=" + String(format:"%f", (location?.getGpsLat())!) + "," + String(format:"%f", (location?.getGpsLong())!) //"42.3550,-71.0656"
//                requestURL += "&destination=" + String(format:"%f", (nextLocation?.getGpsLat())!) + "," + String(format:"%f", (nextLocation?.getGpsLong())!)
//                requestURL += "&mode=walking&key=AIzaSyDFN9FlWd3FzLGOF3oEyp98o-TGDwLLd0s"
//
//
//                httpRequest?.getRequest(requestURL){
//                    (result: NSDictionary) in
//
//
//
//
//                    //print(self.arrivalTimeReference)
//
//                    let numSecondsToWalk = result["routes"]![0]["legs"]!![0]["duration"]!!["value"] as! Int
//                    //print(directionResults["routes"]![0]["legs"]!![0]["duration"]!!["value"])
//
//                    let tmpDate = NSDate(timeIntervalSince1970: self.arrivalTimeReference.timeIntervalSince1970 + Double(numSecondsToWalk))
//
//                    self.arrivalTimeReference = tmpDate
//
//                }
//
//
//
//
//
//
//
//
//                //print(directionResults)
//
//            }
