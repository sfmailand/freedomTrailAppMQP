//
//  segmentedViewController.swift
//  FreedomTrailApp
//
//  Created by Samuel Mailand on 2/7/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class segmentedViewController: UIViewController, ItineraryViewModelDelegate {

    @IBOutlet weak var segmentedControlButtons: UISegmentedControl!
    @IBOutlet weak var myItinerariesviewContainer: UIView!
    @IBOutlet weak var popularItinerariesViewContainer: UIView!
    
    
    var itineraries = ItinerariesViewModel()
    
    //Delegates:
    

    
    func updateView(){
        self.itineraryListEmbeddedViewController.tableView.reloadData()
        print("Updating View")
    }
    
    private var itineraryListEmbeddedViewController: ItineraryListTableViewController!
    private var locationsEmbeddedViewController: LocationTableViewController!
    
    @IBAction func segmentControlButtonChanged(sender: UISegmentedControl) {
        if segmentedControlButtons.selectedSegmentIndex == 0 {
            self.popularItinerariesViewContainer.alpha = 1
            self.myItinerariesviewContainer.alpha = 0
        } else {
            self.popularItinerariesViewContainer.alpha = 0
            self.myItinerariesviewContainer.alpha = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itineraries?.itineraryDelegate = self
        
        
        itineraryListEmbeddedViewController.itineraries = self.itineraries
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Delegates
    
    func saveItinerary(itinerary: Itinerary){
        itineraries!.appendItinerary(itinerary)
        itineraryListEmbeddedViewController.itineraries = itineraries
        itineraryListEmbeddedViewController.tableView.reloadData()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if let vc = segue.destinationViewController as? UITableViewController
            where segue.identifier == "ItinerarySegue" {
                print("Itinerary Segue")
                self.itineraryListEmbeddedViewController = vc as? ItineraryListTableViewController
        }
        
        if let vc2 = segue.destinationViewController as? UINavigationController
            where segue.identifier == "LocationSegue" {
                print("Location Segue")
                self.locationsEmbeddedViewController = vc2.topViewController as? LocationTableViewController
        }
        
        if segue.identifier == "ItineraryBuilderSegue" {
            let itineraryBuilderTabBarController = segue.destinationViewController as! ItineraryBuilderTabViewController
            itineraryBuilderTabBarController.itinerariesModel = itineraries;
        }
        
    }

}
