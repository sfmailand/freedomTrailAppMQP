//
//  ParkTypeTableViewController.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 3/18/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

import OAuthSwift

class ParkTypeTableViewController: UITableViewController {
    
    var itineraryModel: ItinerariesViewModel?
    
    var yelpLocations: [YelpLocation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        yelpRequest()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return (yelpLocations.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "ParkNameCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PublicParkTableViewCell
        
        let location = yelpLocations[indexPath.row]
        print(location.getName())
        
        cell.parkNameLabel.text = location.getName()
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Add to Itinerary", handler:{action, indexpath in
            let selectedLocation = self.yelpLocations[indexPath.row]
            self.itineraryModel?.addLocationToItinerary(selectedLocation)
            self.tableView.editing = false
        });
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        return [moreRowAction];
    }
    
    
    private func yelpRequest(){
        
        let oauthswift  = OAuth1Swift(
            consumerKey: "-KjeymOM8cXvmxhHxr2iJQ",
            consumerSecret: "mjCSrO88wwvYFfSMirQtu8i7aPw",
            requestTokenUrl: "https://www.flickr.com/services/oauth/request_token",
            authorizeUrl:    "https://www.flickr.com/services/oauth/authorize",
            accessTokenUrl:  "https://www.flickr.com/services/oauth/access_token"
        )
        
        
        oauthswift.client.credential.oauth_token =  "cyYjL0ugC5-mgrp7jnQ8_QYzjTgXJGVZ"
        oauthswift.client.credential.oauth_token_secret = "hH1IMQAObbxVtCP-m02qMJ4BXuU"
        
        
        //        var yelpRequestURL = "https://api.yelp.com/v2/search/?sort=1&limit=10&category_filter="
        //        yelpRequestURL += (yelpFilters.getRestaurantIdentifierByType(getName()!))
        //        yelpRequestURL += "&&ll="+String(format:"%f", previousLocation.getGpsLat()) + ","
        //        yelpRequestURL += String(format:"%f", previousLocation.getGpsLong())
        
        //https://api.yelp.com/v2/search/?location=Boston&category_filter=museums
        
        oauthswift.client.get("https://api.yelp.com/v2/search/?location=Boston_MA&category_filter=parks",
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
        print("Saving Yelp Data")
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
            var numResults = json["total"] as! Int
            
            if(numResults > 10){
                numResults = 10
            }
            
            for index in 0...numResults-1{
                let name = (json["businesses"]!![index]["name"] as! String)
                let rating = (json["businesses"]!![index]["rating"] as! Double)
                let reviewCount = (json["businesses"]!![index]["review_count"] as! Int)
                //let imageURL = "iURL: " + (json["businesses"]!![index]["image_url"] as! String)
                let yelpURL = (json["businesses"]!![index]["url"] as! String)
                let yelpID = (json["businesses"]!![index]["id"] as! String)
                let gpsLat = (json["businesses"]!![index]["location"]!!["coordinate"]!!["latitude"] as! Double)
                let gpsLong = (json["businesses"]!![index]["location"]!!["coordinate"]!!["longitude"] as! Double)
                let address = ((json["businesses"]!![index]["location"]!!["display_address"] as! NSArray)[0] as! String) + " " + ((json["businesses"]!![index]["location"]!!["display_address"] as! NSArray)[1] as! String)
                let summary = (json["businesses"]!![index]["snippet_text"] as! String)
                
                //TODO: Add reviews as the description
                let description = (json["businesses"]!![index]["snippet_text"] as! String)
                
                let isClosedResults = (json["businesses"]!![index]["is_closed"] as! Bool)
                let tmpYelpLocation = YelpLocation(name: name, photoURL: "", rating: rating, reviewCount: reviewCount, yelpURL: yelpURL, yelpID: yelpID, gpsLat: gpsLat, gpsLong: gpsLong, address: address, isClosed: isClosedResults, description: description, summary: summary)
                
                yelpLocations.append(tmpYelpLocation)
            }
            
            print(yelpLocations[0].getName())
            
            self.tableView.reloadData()
            
        }catch{
            print("error serializing JSON: \(error)")
        }
    }

}
