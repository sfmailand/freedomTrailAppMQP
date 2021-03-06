//
//  LocationTableViewController.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 1/29/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//


import UIKit

class LocationTableViewController: UITableViewController {
    
    //Properties
    
    
    
    var itineraryModel: ItinerariesViewModel?
    
    
    var trailLocationsModel =  FreedomTrailLocationModel()
    
    var selectedCellIndex: Int!
    
    
    var locations: [FreedomTrailLocation]!
    
    func loadLocations(){
        locations = trailLocationsModel.getFullTrailLocationsArray()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locations = []
        loadLocations()
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
        return locations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "LocationTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LocationTableViewCell
        
        let location = locations[indexPath.row]
        
        cell.locationNameLabel.text = location.getName()
        
        cell.locationPhoto.image = location.getPhoto()
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Add to Itinerary", handler:{action, indexpath in
            let selectedLocation = self.locations[indexPath.row]
            self.itineraryModel?.addLocationToItinerary(selectedLocation)
            self.tableView.editing = false
        });
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        return [moreRowAction];
    }
    

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


    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let locationDetailViewController = segue.destinationViewController as! LocationDetailViewController
        let selectedCellIndex = self.tableView.indexPathForCell(sender as! LocationTableViewCell)
        locationDetailViewController.location = self.locations[selectedCellIndex!.row]
        locationDetailViewController.itineraryModel = itineraryModel
        locationDetailViewController.isAddingToItinerary = true
        
        
    }

}
