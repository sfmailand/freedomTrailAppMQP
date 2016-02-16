//
//  ItineraryBuilderTabViewController.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/15/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit


protocol ItineraryBuilderDelegate{
    func saveItinerary(itinerary: Itinerary)
}

class ItineraryBuilderTabViewController: UITabBarController, ItineraryDelegate {
    
    
   
    var itineraryStopTableViewController = ItineraryStopTableViewController()
    
    var locationTableViewController = LocationTableViewController()
    
    var saveItineraryDelegate: ItineraryBuilderDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTableViewController = self.viewControllers?.last?.childViewControllers.first as! LocationTableViewController
        
        itineraryStopTableViewController = self.viewControllers?.first?.childViewControllers.first as! ItineraryStopTableViewController
       
        locationTableViewController.locationDelegate = itineraryStopTableViewController
        
        itineraryStopTableViewController.itineraryDelegate = self
        // Do any additional setup after loading the view.
        
        
    }
    
    //MARK - Delegates
    
    func sendItinerary(itinerary: Itinerary){
        saveItineraryDelegate?.saveItinerary(itinerary)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
