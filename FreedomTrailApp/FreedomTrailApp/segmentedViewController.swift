//
//  segmentedViewController.swift
//  FreedomTrailApp
//
//  Created by Samuel Mailand on 2/7/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class segmentedViewController: UIViewController {

    @IBOutlet weak var locationViewContainer: UIView!
    @IBOutlet weak var itineraryViewContainer: UIView!
    @IBOutlet weak var segmentedControlButtons: UISegmentedControl!
    
    
    var itineraries = [Itinerary]()
    
    
    var itinerary = Itinerary(name: "Test Itinerary", description: "TEST")
    
    
    
    private var itineraryListEmbeddedViewController: ItineraryListTableViewController!
    private var locationsEmbeddedViewController: LocationTableViewController!
    
    @IBAction func segmentControlButtonChanged(sender: UISegmentedControl) {
        if segmentedControlButtons.selectedSegmentIndex == 0 {
            self.locationViewContainer.alpha = 1
            self.itineraryViewContainer.alpha = 0
        } else {
            itineraryListEmbeddedViewController.itineraries = itineraries
            itineraryListEmbeddedViewController.tableView.reloadData()
            self.locationViewContainer.alpha = 0
            self.itineraryViewContainer.alpha = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itineraries.append(itinerary!)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print("Preparing for Segue")
        
        if let vc = segue.destinationViewController as? UINavigationController
            where segue.identifier == "ItinerarySegue" {
                print(vc.topViewController)
                self.itineraryListEmbeddedViewController = vc.topViewController as? ItineraryListTableViewController
        }
        
        if let vc2 = segue.destinationViewController as? UINavigationController
            where segue.identifier == "LocationSegue" {
                print(vc2.topViewController)
                self.locationsEmbeddedViewController = vc2.topViewController as? LocationTableViewController
        }
        
        if segue.identifier == "ItineraryBuilderSegue" {
            let itineraryBuilderTabBarController = segue.destinationViewController as! ItineraryBuilderTabViewController
            itineraryBuilderTabBarController.itineraries = itineraries
            
        }
        
    }

}
