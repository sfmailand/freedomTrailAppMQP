//
//  LocationViewController.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 1/30/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    var location: Location?
    @IBOutlet weak var locationPhoto: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var directionsIcon: UIImageView!

    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabel.text = location!.name
        
        if((location!.photo) != nil){
            locationPhoto.image = location!.photo
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        directionsIcon.userInteractionEnabled = true
        directionsIcon.addGestureRecognizer(tapGestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions:
    
    func imageTapped(img: AnyObject)
    {
        print("Directions Tapped")
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
