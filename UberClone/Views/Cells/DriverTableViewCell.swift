//
//  DriverTableViewCell.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 1/19/21.
//  Copyright © 2021 fchiarello. All rights reserved.
//

import UIKit

class DriverTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
