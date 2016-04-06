//
//  LocationViewController.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 1/30/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    var itineraryModel: ItinerariesViewModel!
    @IBOutlet weak var locationPhoto: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var directionsIcon: UIImageView!
    @IBOutlet weak var locationSummary: UITextView!
    @IBOutlet weak var locationDetails: UITextView!
    @IBOutlet weak var previousLocationIcon: UIImageView!
    @IBOutlet weak var nextLocationIcon: UIImageView!
    @IBOutlet weak var addToItineraryButton: UIButton!
    
    var isAddingToItinerary = false

    var location: Location!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        if(isAddingToItinerary == true){
            print("Adding to Itinerary")
            previousLocationIcon.hidden = true
            nextLocationIcon.hidden = true
            directionsIcon.hidden = true
            
        }
        else{
            addToItineraryButton.hidden = true
            print("Not adding to itinerary")
            location = itineraryModel.getCurrentLocation()

            let directionsTapRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.directionsIconTapped))
            directionsIcon.userInteractionEnabled = true
            directionsIcon.addGestureRecognizer(directionsTapRecognizer)
            
            
            let previousLocationTapRecognizer = UITapGestureRecognizer(target:self, action: #selector(self.previousLocationIconTapped))
            previousLocationIcon.userInteractionEnabled = true
            previousLocationIcon.addGestureRecognizer(previousLocationTapRecognizer)
            
            
            let nextLocationTapRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.nextLocationIconTapped))
            nextLocationIcon.userInteractionEnabled = true
            nextLocationIcon.addGestureRecognizer(nextLocationTapRecognizer)
        }
        
        
        reloadPage()

        
    }

    @IBAction func addToItineraryAction(sender: UIButton) {
        itineraryModel.addLocationToItinerary(location)
        navigationController!.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func reloadPage(){
        locationLabel.text = location!.getName()
        
        if((location!.getName()) != nil){
            locationPhoto.image = location!.getPhoto()
        }
        
        locationSummary.text = location.getSummary()
        locationDetails.text = location.getDescription()
    }
    
    //MARK: Actions:
    
    
    func previousLocationIconTapped(){
        location = itineraryModel.getPreviousLocation()
        reloadPage()
    }
    
    func nextLocationIconTapped(){
        location = itineraryModel.getNextLocation()
        reloadPage()
    }
    
    func directionsIconTapped(img: AnyObject)
    {
        
        
        let tmpLat:Double = location!.getGpsLat()
        let gpsLat:String = String(format:"%f", tmpLat)
        
        
        let tmpLong:Double = location!.getGpsLong()
        let gpsLong:String = String(format:"%f", tmpLong)
        
        
        var directionURLString = "http://maps.apple.com/?saddr=Current+Location&daddr="+gpsLat+","+gpsLong+"&dirflg=w"
        
        directionURLString = directionURLString.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let url : NSURL = NSURL(string: directionURLString+"+Boston+Massachusetts")!
        if UIApplication.sharedApplication().canOpenURL(url) {
            UIApplication.sharedApplication().openURL(url)
        }
        
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
