//
//  ItineraryBuilderTabViewController.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/15/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit


class ItineraryBuilderTabViewController: UITabBarController {
    
    
   
    var itineraryStopTableViewController = ItineraryStopTableViewController()
    
    var locationTableViewController = LocationTableViewController()
    
    var itinerariesModel: ItinerariesViewModel?
    
    var isNewItinerary: Bool!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationTableViewController = self.viewControllers?.first?.childViewControllers.first as! LocationTableViewController
        
        itineraryStopTableViewController = self.viewControllers?.last?.childViewControllers.first as! ItineraryStopTableViewController
        
        if(isNewItinerary == true){
            itinerariesModel?.tmpInitItinerary()
        }
        
        
        locationTableViewController.itineraryModel = self.itinerariesModel
        
        itineraryStopTableViewController.itineraryModel = self.itinerariesModel
        
        
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
