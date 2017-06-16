//
//  DateLabel.swift
//  Bookme
//
//  Created by Janet Rivas on 6/15/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import Foundation
import UIKit

class DateLabelCellView: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func setLabelText( text : String ) {
        dateLabel.text = text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}




