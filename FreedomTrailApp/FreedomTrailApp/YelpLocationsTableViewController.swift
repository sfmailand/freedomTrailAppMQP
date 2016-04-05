//
//  YelpLocationsTableViewController.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 3/20/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class YelpLocationsTableViewController: UITableViewController {
    
    var itineraryModel: ItinerariesViewModel?
    
    var yelpLocations: [YelpLocation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateView:", name: yelpLocationLoadedNotificationKey, object: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func updateView(notification: NSNotification){
        let userInfo:Dictionary<String, [YelpLocation]!> = notification.userInfo as! Dictionary<String, [YelpLocation]!>
        self.yelpLocations = userInfo["location"]!
        self.tableView.reloadData()
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
        return yelpLocations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "yelpLocationResultCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! YelpLocationTableViewCell
        
        let location = yelpLocations[indexPath.row]
        
        cell.yelpLocationName.text = location.getName()
        cell.numYelpReviews.text = String(location.reviewCount) + " reviews"
        cell.yelpURL = location.yelpURL
        
        
        setYelpStarRatings(location, cell: cell)
        
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let yelpURLString = yelpLocations[indexPath.row].yelpURL
        
        let tmpYelpLocation = yelpLocations[indexPath.row]
        
        
        if let appURL = NSURL(string: "yelp:///biz/"+tmpYelpLocation.getYelpID()) {
            let canOpen = UIApplication.sharedApplication().canOpenURL(appURL)
            
            if(canOpen == true){
                UIApplication.sharedApplication().openURL(appURL)
            }
            else{
                UIApplication.sharedApplication().openURL(NSURL(string: yelpURLString)!)
            }
        }

    }
    
    // Override to support editing the table view.
    // REQUIRED for iOS8
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //        if editingStyle == .Delete {
        //            // Delete the row from the data source
        //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        //        } else if editingStyle == .Insert {
        //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //        }
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Confirm", handler:{action, indexpath in
            let selectedLocation = self.yelpLocations[indexPath.row]
            
            //TODO: Yelp Locaiton is not being finalized correctly. It's 
            //finalizing either the one before or after it in the table
            print("Index: " + String(indexPath.row))
            self.itineraryModel?.finalizeYelpLocation(selectedLocation)
            self.tableView.editing = false
            print("Itinerary Updated - Notification")
            NSNotificationCenter.defaultCenter().postNotificationName(singleItineraryUpdatedNotificationKey, object: self)
            self.navigationController?.popViewControllerAnimated(true)
        });
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        return [moreRowAction];
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func setYelpStarRatings(location: YelpLocation, cell: YelpLocationTableViewCell){
        print(location.getName())
        print(location.rating)
        cell.firstYelpStar.image = UIImage(named: "yelpStar_0")
        cell.secondYelpStar.image = UIImage(named: "yelpStar_0")
        cell.thirdYelpStar.image = UIImage(named: "yelpStar_0")
        cell.fourthYelpStar.image = UIImage(named: "yelpStar_0")
        cell.fifthYelpStar.image = UIImage(named: "yelpStar_0")
        
        if(location.rating == 5.0){
            print("5 Stars")
            cell.firstYelpStar.image = UIImage(named: "yelpStar_5")
            cell.secondYelpStar.image = UIImage(named: "yelpStar_5")
            cell.thirdYelpStar.image = UIImage(named: "yelpStar_5")
            cell.fourthYelpStar.image = UIImage(named: "yelpStar_5")
            cell.fifthYelpStar.image = UIImage(named: "yelpStar_5")
        }
        else if(location.rating >= 4.0){
            print("4 Stars")
            cell.firstYelpStar.image = UIImage(named: "yelpStar_4")
            cell.secondYelpStar.image = UIImage(named: "yelpStar_4")
            cell.thirdYelpStar.image = UIImage(named: "yelpStar_4")
            cell.fourthYelpStar.image = UIImage(named: "yelpStar_4")
            if(location.rating == 4.5){
                cell.fifthYelpStar.image = UIImage(named: "yelpStar_4_5")
            }
        }
        else if(location.rating >= 3.0){
            cell.firstYelpStar.image = UIImage(named: "yelpStar_3")
            cell.secondYelpStar.image = UIImage(named: "yelpStar_3")
            cell.thirdYelpStar.image = UIImage(named: "yelpStar_3")
            if(location.rating == 3.5){
                print("3.5 Stars")

                cell.fourthYelpStar.image = UIImage(named: "yelpStar_3_5")
            }
        }
        else if(location.rating >= 2.0){
            print("2 Stars")
            cell.firstYelpStar.image = UIImage(named: "yelpStar_2")
            cell.secondYelpStar.image = UIImage(named: "yelpStar_2")
            if(location.rating == 2.5){
                cell.thirdYelpStar.image = UIImage(named: "yelpStar_2_5")
            }
        }
        else if(location.rating >= 1.0){
            print("1 Star")
            cell.firstYelpStar.image = UIImage(named: "yelpStar_1")
            if(location.rating == 1.5){
                cell.secondYelpStar.image = UIImage(named: "yelpStar_1_5")
            }
        }
        else if(location.rating == 0.5){
            print("0.5 Star")
            cell.firstYelpStar.image = UIImage(named: "yelpStar_1_5")
        }


    }

}
