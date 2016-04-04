//
//  ItineraryStopTableViewCell.swift
//  FreedomTrailApp
//
//  Created by Samuel Mailand on 2/10/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class ItineraryStopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itineraryStopLabel: UILabel!
    @IBOutlet weak var subheadingLabel: UILabel!
    var isTrailLocationFinalized: Bool!
    
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
