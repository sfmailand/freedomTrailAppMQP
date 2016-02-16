//
//  LocationTableViewController.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 1/29/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//


import UIKit

protocol LocationTableViewControllerDelegate{
    func sendLocation(location: Location)
}

class LocationTableViewController: UITableViewController {
    
    //Properties
    
    var locations = [Location]()
    var itineraries = ItineraryList()
    
    var locationDelegate: LocationTableViewControllerDelegate?
    
    func loadLocations(){
        let bostonCommonLocation = Location(name: "Boston Common", photo: nil)!
        let stateHouseLocation = Location(name: "State House", photo: nil)!
        let parkStreetChurchLocation = Location(name: "Park Street Church", photo: nil)!
        let granaryGroundLocation = Location(name: "Granary Burying Ground", photo: nil)!
        let kingChapelLocation = Location(name: "King's Chapel", photo: nil)!
        let chapelBuryingLocation = Location(name: "King's Chapel Burying Ground", photo: nil)!
        let benFranklinLocation = Location(name: "Benjamin Franklin Statue & Boston Latin School", photo: nil)!
        let oldBookStoreLocation = Location(name: "Old Corner Book Store", photo: nil)!
        let southMeetingHouseLocation = Location(name: "Old South Meeting House", photo: nil)!
        let oldStateHouseLocation = Location(name: "Old State House", photo: nil)!
        let bostonMassacreLocation = Location(name: "Site of Boston Massacre", photo: nil)!
        let fanueuilHallLocation = Location(name: "Faneuil Hall", photo: nil)!
        let paulRevereLocation = Location(name: "Paul Revere House", photo: nil)!
        let northChurchLocation = Location(name: "Old North Church", photo: nil)!
        let coppsHillLocation = Location(name: "Copp's Hill Burying Ground", photo: nil)!
        let bunkerHillLocation = Location(name: "Bunker Hill Monument", photo: nil)!
        let ussConstitutionLocation = Location(name: "USS Constitution", photo: nil)!
        
        locations += [bostonCommonLocation, stateHouseLocation, parkStreetChurchLocation, granaryGroundLocation,
                       kingChapelLocation, chapelBuryingLocation, benFranklinLocation, oldBookStoreLocation,
                       southMeetingHouseLocation, oldStateHouseLocation, bostonMassacreLocation, fanueuilHallLocation,
                       paulRevereLocation, northChurchLocation, coppsHillLocation, bunkerHillLocation, ussConstitutionLocation]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //itineraryTabViewController = (self.parentViewController?.parentViewController?.parentViewController as? ItineraryBuilderTabViewController)!
        //itineraries = itineraryTabViewController.itineraries
        //Load Sample Data
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
        
        cell.locationNameLabel.text = location.name
        
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
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Add to Itinerary", handler:{action, indexpath in
            let selectedLocation = self.locations[indexPath.row]
            self.locationDelegate?.sendLocation(selectedLocation)
            print("HERE")
        });
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        return [moreRowAction];
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let locationDetailViewController = segue.destinationViewController as! LocationDetailViewController
        
        if let selectedLocationCell = sender as? LocationTableViewCell{
            let indexPath = tableView.indexPathForCell(selectedLocationCell)!
            let selectedLocation = locations[indexPath.row]
            print("TableViewController")
            let itineraryTabViewController = self.parentViewController?.parentViewController
            let itinerary = (itineraryTabViewController as? ItineraryBuilderTabViewController)!.itineraries?.getLastItinerary()
            locationDetailViewController.itinerary = itinerary
            locationDetailViewController.location = selectedLocation
        }
        
        
    }

}
