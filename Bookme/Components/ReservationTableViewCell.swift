//
//  ReservationTableViewCell.swift
//  Bookme
//
//  Created by Janet Rivas on 6/17/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    
    @IBOutlet weak var status: UILabel!
    
    
    @IBOutlet weak var imageCustomCell: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
            // Configure the view for the selected state
    }

}
