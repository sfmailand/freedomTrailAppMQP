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
    
    @IBAction func segmentControlButtonChanged(sender: UISegmentedControl) {
        if segmentedControlButtons.selectedSegmentIndex == 0 {
            UIView.animateWithDuration(0.5, animations: {
                self.locationViewContainer.alpha = 1
                self.itineraryViewContainer.alpha = 0
            })
        } else {
            UIView.animateWithDuration(0.5, animations: {
                self.locationViewContainer.alpha = 0
                self.itineraryViewContainer.alpha = 1
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
