//
//  EmailCellView.swift
//  Bookme
//
//  Created by Janet Rivas on 6/16/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import UIKit

class EmailCellView: UITableViewCell {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    var email : UITextField!
    
    @IBAction func editDidChange(_ sender: UITextField, forEvent event: UIEvent) {
        
        email = sender
    }
    
    @IBAction func emailValueChanged(_ sender: UITextField, forEvent event: UIEvent) {
        email = sender
    }
    
    func getText() -> String {
        
        return emailTextField.text!
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
