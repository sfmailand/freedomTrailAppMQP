//
//  LocationTableViewCell.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 1/29/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    
    //Properties
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationPhoto: UIImageView!
    
    var isFreedomTrailLocation: Bool!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
