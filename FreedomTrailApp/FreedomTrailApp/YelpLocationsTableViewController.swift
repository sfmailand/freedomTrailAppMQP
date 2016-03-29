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
        
        print(yelpURLString)
        
        
        UIApplication.sharedApplication().openURL(NSURL(string: yelpURLString)!)
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
            self.itineraryModel?.finalizeYelpLocation(selectedLocation)
            self.tableView.editing = false
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

}
