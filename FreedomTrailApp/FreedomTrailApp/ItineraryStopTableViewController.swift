//
//  ItineraryStopTableViewController.swift
//  FreedomTrailApp
//
//  Created by Samuel Mailand on 2/10/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

protocol ItineraryStopTableViewDelegate{
    
    func saveItinerary()
    
}

class ItineraryStopTableViewController: UITableViewController {
    
    
    var itinerary: Itinerary?
    
    var saveItineraryDelegate: ItineraryStopTableViewDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //itineraryTabViewController = (self.parentViewController?.parentViewController as? ItineraryBuilderTabViewController)!
        //itineraryStops = (itineraryTabViewController.itineraries!.getFirstItinerary().locations)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
    }

    
    override func viewWillAppear(animated: Bool) {
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

        var itineraryNameTextField = UITextField()
        itineraryNameTextField.placeholder = "Untitled Itinerary"

        let saveItineraryAlert = UIAlertController(title: "Save Itinerary", message: "Please Enter the name of this Itinerary", preferredStyle: .Alert)
        
        let cancelItinerarySave = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let confirmItinerarySave = UIAlertAction(title: "Confirm", style: .Default, handler: {
            action in
                    let nameTextField = saveItineraryAlert.textFields!.first! as UITextField
                    self.itinerary?.name = nameTextField.text!
                    self.saveItineraryDelegate?.saveItinerary()
                    self.dismissViewControllerAnimated(true, completion: nil)
            }
        )
        
        
        saveItineraryAlert.addTextFieldWithConfigurationHandler { (itineraryNameTextField) -> Void in
            itineraryNameTextField.placeholder = "Untitled Itinerary"
        }
        saveItineraryAlert.addAction(confirmItinerarySave)
        saveItineraryAlert.addAction(cancelItinerarySave)
        presentViewController(saveItineraryAlert, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (itinerary?.locations.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "ItineraryStopViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ItineraryStopTableViewCell
        
        let location = itinerary?.locations[indexPath.row]
        
        cell.itineraryStopLabel.text = location!.name
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
