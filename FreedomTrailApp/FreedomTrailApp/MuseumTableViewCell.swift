//
//  MuseumTableViewCell.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 3/31/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import UIKit

class MuseumTableViewCell: UITableViewCell {

    @IBOutlet weak var museumNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
