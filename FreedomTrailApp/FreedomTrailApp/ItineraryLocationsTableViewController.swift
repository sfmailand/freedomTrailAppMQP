//
//  ItineraryStopTableViewController.swift
//  FreedomTrailApp
//
//  Created by Samuel Mailand on 2/10/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit


class ItineraryLocationsTableViewController: UITableViewController {
    
    
    var itineraryModel: ItinerariesViewModel?
    
    var selectedCellIndex: Int!

    

    override func viewDidLoad() {
        
        //Add observer for when a singlular itinerary is updated
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateView", name: singleItineraryUpdatedNotificationKey, object: nil)
        print("Loaded")
        
    }
    
    func updateView(){
        print("Updating List of Stops in Itinerary")
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelItineraryCreation(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //Calls the delegate method from ItineraryBuilderTabViewController
    //to append the itinerary that's stored in that controller
    //to the ItineraryViewModel
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
    

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return (itineraryModel?.getCurrentItinerary().getLocations().count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "ItineraryStopViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ItineraryStopTableViewCell
        
        let location = itineraryModel?.getCurrentItinerary().getLocationAtIndex(indexPath.row)
        
        cell.itineraryStopLabel.text = location!.getName()
        
        cell.isTrailLocationFinalized = location?.isLocationFinalized()
        
        return cell
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            self.itineraryModel!.getCurrentItinerary().deleteLocation(indexPath.row)
            self.tableView.editing = false
        });
        moreRowAction.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0);
        
        return [moreRowAction];
    }


    // MARK: - Navigation
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Table view cells are reused and should be dequeued using a cell identifier
        
        selectedCellIndex = indexPath.row
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ItineraryStopTableViewCell
        
        let locationIsFinalized = cell.isTrailLocationFinalized!

        if(locationIsFinalized){
            performSegueWithIdentifier("locationDetailSegue", sender: self)
        }
        else{
            performSegueWithIdentifier("yelpLocationSelectionSegue", sender: self)
        }
        
        
        
        
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        
        if(segue.identifier == "locationDetailSegue"){
            let locationDetailViewController = segue.destinationViewController as! LocationDetailViewController
            
            let selectedLocation = itineraryModel?.getCurrentItinerary().getLocationAtIndex(selectedCellIndex)
            locationDetailViewController.location = selectedLocation
        }
        
        if(segue.identifier == "yelpLocationSelectionSegue"){
            //let yelpLocationTableViewController = segue.destinationViewController as! YelpLocationsTableViewController
            
            let selectedLocation = itineraryModel?.getCurrentItinerary().getLocationAtIndex(selectedCellIndex)
            
            selectedLocation!.yelpRequest()
            //yelpLocationTableViewController.location = selectedLocation
            
            
        }
        
        

    }


}
