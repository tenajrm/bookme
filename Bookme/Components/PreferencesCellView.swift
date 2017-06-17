//
//  preferencesCellView.swift
//  Bookme
//
//  Created by Janet Rivas-Mendoza (Contractor) on 6/16/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import UIKit

class PreferencesCellView: UITableViewCell {

    @IBOutlet weak var preferencesTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setClean() {
        if (self.preferencesTextView.text == "Special Preferences") {
            preferencesTextView.text = ""
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
