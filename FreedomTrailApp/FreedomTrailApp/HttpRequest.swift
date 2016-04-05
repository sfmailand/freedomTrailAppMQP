//
//  httpRequest.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 4/4/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import Foundation


public class HttpRequest{
    
    
    init?(){
    }
    
    
    public func getRequest(requestString: String, completion: (result: NSDictionary) -> Void){
        //print("GET REQUEST: " + requestString)
        
        var returnDictionary = NSDictionary()
        
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

                    completion(result: convertedJson)
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        

        
    }
}