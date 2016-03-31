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
    @IBOutlet weak var addToItineraryButton: UIButton!
    @IBOutlet weak var locationSummary: UITextView!
    @IBOutlet weak var locationDetails: UITextView!

    var location: Location!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        location = itineraryModel.getCurrentLocation()
        
        locationLabel.text = location!.getName()
        
        if((location!.getName()) != nil){
            locationPhoto.image = location!.getPhoto()
        }
        
        let directionsTapRecognizer = UITapGestureRecognizer(target:self, action:Selector("directionsIconTapped:"))
        directionsIcon.userInteractionEnabled = true
        directionsIcon.addGestureRecognizer(directionsTapRecognizer)
        
        
        let previousLocationTapRecognizer = UITapGestureRecognizer(target:self, action:Selector("previousLocationIconTapped:"))
        directionsIcon.userInteractionEnabled = true
        directionsIcon.addGestureRecognizer(previousLocationTapRecognizer)
        
        
        let nextLocationTapRecognizer = UITapGestureRecognizer(target:self, action:Selector("nextLocationIconTapped:"))
        directionsIcon.userInteractionEnabled = true
        directionsIcon.addGestureRecognizer(nextLocationTapRecognizer)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions:
    
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
