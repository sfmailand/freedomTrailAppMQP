//
//  ItineraryTableViewCell.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 2/11/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class ItineraryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itineraryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
