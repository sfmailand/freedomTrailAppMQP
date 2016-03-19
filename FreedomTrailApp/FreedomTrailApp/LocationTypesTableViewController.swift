//
//  LocationTypesTableViewController.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/29/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class LocationTypesTableViewController: UITableViewController {
    
    var itineraryModel: ItinerariesViewModel?
    
    var locationTypes: [String] = ["Restaurants", "Freedom Trail Locations", "Museums", "Public Parks"]

    override func viewDidLoad() {
        super.viewDidLoad()

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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    @IBAction func cancelItineraryCreation(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func saveItinerary(sender: UIBarButtonItem) {
        
        let itineraryNameTextField = UITextField()
        itineraryNameTextField.placeholder = "Untitled Itinerary"
        
        let saveItineraryAlert = UIAlertController(title: "Save Itinerary", message: "Please Enter the name of this Itinerary", preferredStyle: .Alert)
        
        let cancelItinerarySave = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let confirmItinerarySave = UIAlertAction(title: "Confirm", style: .Default, handler: {
            action in
            let nameTextField = saveItineraryAlert.textFields!.first! as UITextField
            self.itineraryModel?.changeItineraryName(nameTextField.text!)
            self.dismissViewControllerAnimated(true, completion: nil)
            NSNotificationCenter.defaultCenter().removeObserver(self)
            self.itineraryModel?.saveItinerary()
            }
        )
        
        
        saveItineraryAlert.addTextFieldWithConfigurationHandler { (itineraryNameTextField) -> Void in
            itineraryNameTextField.placeholder = "Untitled Itinerary"
        }
        saveItineraryAlert.addAction(confirmItinerarySave)
        saveItineraryAlert.addAction(cancelItinerarySave)
        
        if(itineraryModel?.areCreatingNewItineary() == true){
            presentViewController(saveItineraryAlert, animated: true, completion: nil)
        }
        else{
            self.itineraryModel?.saveItinerary()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let locationTableView = segue.destinationViewController as! LocationTableViewController
//        locationTableView.itineraryModel = itineraryModel

        
        if segue.identifier == "freedomTrailSegue" {
            let trailLocationsListTableViewController = segue.destinationViewController as! LocationTableViewController
            trailLocationsListTableViewController.itineraryModel = itineraryModel;
        }
        
        if segue.identifier == "museumsSegue" {
            let museumTypeLocationTableViewController = segue.destinationViewController as! MuseumTypeTableViewController
            museumTypeLocationTableViewController.itineraryModel = itineraryModel;
        }
        
        if segue.identifier == "restaurantSegue" {
            let restaurantTypeTableViewController = segue.destinationViewController as! RestaurantTypeTableViewController
            restaurantTypeTableViewController.itineraryModel = itineraryModel;
        }
        
        if segue.identifier == "publicParkSegue" {
            let parkTypeTableViewController = segue.destinationViewController as! ParkTypeTableViewController
            parkTypeTableViewController.itineraryModel = itineraryModel;
        }

    }

}
