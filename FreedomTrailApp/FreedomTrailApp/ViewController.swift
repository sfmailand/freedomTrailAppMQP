//
//  ViewController.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 1/20/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBOutlet weak var textLabel: UILabel!
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            textLabel.text = "First selected";
        case 1:
            textLabel.text = "Second Segment selected";
        default:
            break; 
        }
    }
}

