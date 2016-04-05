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
    
    
    init?(itineraryModel: ItinerariesViewModel){
        self.itineraryModel = itineraryModel
    }
    
    public func getArrivalTimeRequest(){
        let numLocations = itineraryModel.getNumberOfLocations()
        let locations = itineraryModel.getAllLocationsInItinerary()
        
        for index in 0...numLocations{
            var previousGpsLat: Double
            var previousGpsLong: Double
            let currentGpsLat = locations[index].getGpsLat()
            let currentGpsLong = locations[index].getGpsLong()
            
            
            if(index == 0){
                previousGpsLat = currentGpsLat
                previousGpsLong = currentGpsLong
            }
            else{
                previousGpsLat = locations[index - 1].getGpsLat()
                previousGpsLong = locations[index - 1].getGpsLong()
            }
            
            var requestURL = "https://maps.googleapis.com/maps/api/directions/json?"
            requestURL += "origin=" + String(format:"%f", (previousGpsLat)) + "," + String(format:"%f", (previousGpsLong)) //"42.3550,-71.0656"
            requestURL += "&destination=" + String(format:"%f", currentGpsLat) + "," + String(format:"%f", currentGpsLong)
            requestURL += "&mode=walking&key=AIzaSyDFN9FlWd3FzLGOF3oEyp98o-TGDwLLd0s"

            
        }
        
    }
    
    
    public func getRequest(requestString: String){
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
                    print(convertedJson)
                    
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
