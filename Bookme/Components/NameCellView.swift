//
//  NameCellView.swift
//  Bookme
//
//  Created by Janet Rivas-Mendoza (Contractor) on 6/16/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import UIKit

class NameCellView: UITableViewCell {
    
    @IBOutlet weak var nameTextFieldCell: UITextField!
    
    //EditingChanged
    @IBAction func nameTextField(_ sender: UITextField, forEvent event: UIEvent) {
        
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
