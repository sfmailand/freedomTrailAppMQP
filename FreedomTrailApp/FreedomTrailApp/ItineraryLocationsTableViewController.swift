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

    @IBOutlet weak var editTimeIcon: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var httpRequest: HttpRequest!
    
    
    var arrivalTimeReference: NSDate!
    
    let timeFormatter = NSDateFormatter()
    
    

    override func viewDidLoad() {
        
        print("DID LOAD")
        
        httpRequest = HttpRequest(itineraryModel: itineraryModel!)
        
        //Add observer for when a singlular itinerary is updated
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateView", name: singleItineraryUpdatedNotificationKey, object: nil)

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateViewWithOutReload), name: completedArrivalTimeGetRequest, object: nil)

        
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureRecognized(_:)))
        
        tableView.addGestureRecognizer(longpress)
        
        datePicker.setDate((itineraryModel?.getStartTime())!, animated: false)
        
        datePicker.addTarget(self, action: "changedAction", forControlEvents: UIControlEvents.ValueChanged)
        
        arrivalTimeReference = datePicker.date
        
        timeFormatter.dateFormat = "hh:mm a"
        
        httpRequest.getArrivalTimeRequest()
        
        

    }

    
    func updateView(){
        arrivalTimeReference = datePicker.date
        self.tableView.reloadData()
        print("Update View")
        httpRequest.getArrivalTimeRequest()
    }
    
    func updateViewWithOutReload(){
        print("Update View -- No Reload")

        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Cancel Button
    @IBAction func cancelItineraryCreation(sender: UIBarButtonItem) {
        self.itineraryModel!.cancelItineraryCreation()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func changedAction(){
        itineraryModel?.setStartTime(datePicker.date)
        print("Changed Time")
        httpRequest.getArrivalTimeRequest()
    }
    
    
    
    
    //Save Button
    //Calls the delegate method from ItineraryBuilderTabViewController
    //to append the itinerary that's stored in that controller
    //to the ItineraryViewModel
    @IBAction func saveItinerary(sender: UIBarButtonItem) {
        
        
        //POPUP
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
        
        if(itineraryModel?.isCreatingNewItineary() == true){
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

        cell.locationImage.image = location?.getPhoto()
        
        cell.isTrailLocationFinalized = location?.isLocationFinalized()
        cell.subheadingLabel.text = ""
        cell.arrivalTimeLabel.text = ""
        
        
        if(location?.isLocationFinalized() == false){
            let nearbyLocation = itineraryModel?.getNearbyLocation(indexPath.row)
            cell.backgroundColor = colorSetter(220, green: 220, blue: 220)
            cell.subheadingLabel.text = "(Near " + nearbyLocation!.getName()! + ")"
            cell.arrivalTimeLabel.text = ""
            cell.itineraryStopLabel.text = "Find nearby " + location!.getName()!
            
        }
        else{
            cell.backgroundColor = colorSetter(255, green: 255, blue: 255)
            cell.itineraryStopLabel.text = location!.getName()
            cell.arrivalTimeLabel.text = "Arrival: ~" + self.timeFormatter.stringFromDate((location?.getArrivalTime())!)
        }
        
        
        
        
        
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
        
        let itineraryStopCell = tableView.cellForRowAtIndexPath(indexPath) as! ItineraryStopTableViewCell
        
        let locationIsFinalized = itineraryStopCell.isTrailLocationFinalized!

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
            
            itineraryModel?.setSelectedLocationIndex(selectedCellIndex)
            locationDetailViewController.itineraryModel = itineraryModel
        }
        
        if(segue.identifier == "yelpLocationSelectionSegue"){
            
            let yelpLocationTableViewController = segue.destinationViewController as! YelpLocationsTableViewController
            
            let selectedLocation = itineraryModel?.getCurrentItinerary().getLocationAtIndex(selectedCellIndex) as! YelpLocation
            
            itineraryModel?.setSelectedLocationIndex(selectedCellIndex)
            
            
            selectedLocation.yelpRequest((itineraryModel?.getNearbyLocation(selectedCellIndex))!)
            
            
            yelpLocationTableViewController.itineraryModel = itineraryModel
            
            //yelpLocationTableViewController.location = selectedLocation
            
            
        }
        
        

    }
    
    private func colorSetter(red: Int, green: Int, blue: Int) -> UIColor{
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1)
    }
    
    
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer){
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        
        let state = longPress.state
        
        var locationInView = longPress.locationInView(tableView)
        
        var indexPath = tableView.indexPathForRowAtPoint(locationInView)
        
        struct My{
            static var cellSnapshot: UIView? = nil
        }
        
        struct Path{
            static var initialIndexPath: NSIndexPath? = nil
        }
        
        switch state {
        case UIGestureRecognizerState.Began:
            
            if indexPath != nil {
                
                Path.initialIndexPath = indexPath
                
                let cell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
                
                My.cellSnapshot  = snapshopOfCell(cell)
                
                var center = cell.center
                
                My.cellSnapshot!.center = center
                
                My.cellSnapshot!.alpha = 0.0
                
                tableView.addSubview(My.cellSnapshot!)
                
                
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    center.y = locationInView.y
                    
                    My.cellSnapshot!.center = center
                    
                    My.cellSnapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                    
                    My.cellSnapshot!.alpha = 0.98
                    
                    cell.alpha = 0.0
                    
                    
                    
                    }, completion: { (finished) -> Void in
                        
                        if finished {
                            
                            cell.hidden = true
                            
                        }
                        
                })
                
            }
            
        case UIGestureRecognizerState.Changed:
            var center = My.cellSnapshot!.center
            center.y = locationInView.y
            My.cellSnapshot!.center = center
            
        if((indexPath != nil) && (indexPath != Path.initialIndexPath)){
            itineraryModel!.swapLocations(indexPath!.row, oldIndex: Path.initialIndexPath!.row)
            Path.initialIndexPath = indexPath
            }
        default:
            let cell = tableView.cellForRowAtIndexPath(Path.initialIndexPath!) as UITableViewCell!
            
            cell.hidden = false
            
            cell.alpha = 0.0
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                
                My.cellSnapshot!.center = cell.center
                
                My.cellSnapshot!.transform = CGAffineTransformIdentity
                
                My.cellSnapshot!.alpha = 0.0
                
                cell.alpha = 1.0
                
                }, completion: { (finished) -> Void in
                    
                    if finished {
                        
                        Path.initialIndexPath = nil
                        
                        My.cellSnapshot!.removeFromSuperview()
                        
                        My.cellSnapshot = nil
                        
                    }
                    
            })
            tableView.reloadData()
        }
        
        
        
        
    }
    
    func snapshopOfCell(inputView: UIView) -> UIView{
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        
        UIGraphicsEndImageContext()
        
        let cellSnapshot: UIView = UIImageView(image: image)
        
        cellSnapshot.layer.masksToBounds = false
        
        cellSnapshot.layer.cornerRadius = 0.0
        
        cellSnapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        
        cellSnapshot.layer.shadowRadius = 5.0
        
        cellSnapshot.layer.shadowOpacity = 0.4
        
        return cellSnapshot
    }
    
        


}
