//
//  ItineraryBuilderTabViewController.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/15/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit


class ItineraryTabViewController: UITabBarController {
    
    
   
    var itineraryLocationsTableViewController = ItineraryLocationsTableViewController()
    
    var locationTableViewController = LocationTypesTableViewController()
    
    var itinerariesModel: ItinerariesViewModel?
    
    var isNewItinerary: Bool!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationTableViewController = self.viewControllers?.first?.childViewControllers.first as! LocationTypesTableViewController
        
        itineraryLocationsTableViewController = self.viewControllers?.last?.childViewControllers.first as! ItineraryLocationsTableViewController
        
        if(isNewItinerary == true){
            itinerariesModel?.tmpInitItinerary()
        }
        
        
        locationTableViewController.itineraryModel = self.itinerariesModel
        
        itineraryLocationsTableViewController.itineraryModel = self.itinerariesModel
        
        
        self.selectedIndex = 1
    }

    
    //MARK - Delegates
    

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
