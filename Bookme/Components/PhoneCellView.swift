//
//  PhoneViewCell.swift
//  Bookme
//
//  Created by Janet Rivas-Mendoza (Contractor) on 6/16/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import UIKit

class PhoneCellView: UITableViewCell {
    
    @IBOutlet weak var phoneTextCellView: UITextField!
    
    @IBAction func editingChange(_ sender: Any) {
        
        let text = sender as! UITextField
        self.phoneTextCellView.text = text.text
    }
    
    @IBAction func editEnd(_ sender: Any) {
        let text = sender as! UITextField
        self.phoneTextCellView.text = text.text
    }
    
    @IBAction func valueChange(_ sender: Any, forEvent event: UIEvent) {
        let text = sender as! UITextField
        self.phoneTextCellView.text = text.text
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
