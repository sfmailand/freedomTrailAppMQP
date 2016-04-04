//
//  YelpLocationTableViewCell.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 3/22/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class YelpLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var yelpLocationName: UILabel!
    @IBOutlet weak var firstYelpStar: UIImageView!
    @IBOutlet weak var secondYelpStar: UIImageView!
    @IBOutlet weak var thirdYelpStar: UIImageView!
    @IBOutlet weak var fourthYelpStar: UIImageView!
    @IBOutlet weak var fifthYelpStar: UIImageView!
    @IBOutlet weak var numYelpReviews: UILabel!
    @IBOutlet weak var informationIcon: UIImageView!
    
    var yelpURL: String!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        
        let yelpInfoTapRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.yelpInfoIconTapped))
        informationIcon.userInteractionEnabled = true
        informationIcon.addGestureRecognizer(yelpInfoTapRecognizer)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func yelpInfoIconTapped(){
        UIApplication.sharedApplication().openURL(NSURL(string: yelpURL)!)
    }

}
