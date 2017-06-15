//
//  BasicCellView.swift
//  Bookme
//
//  Created by Janet Rivas on 6/14/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import Foundation
import UIKit

class BasicCellView: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var contactInfo: UITextField!
    
    
    
    @IBAction func contactInfoEditing(_ sender: UITextField, forEvent event: UIEvent) {
        
        if contactInfo.textColor == UIColor.lightGray {
            contactInfo.text = ""
            contactInfo.textColor = UIColor.black
        }

    }
    

    
    @IBAction func conctactInfoEndEditing(_ sender: UITextField, forEvent event: UIEvent) {
        
        if (contactInfo.text?.isEmpty)! {
            contactInfo.text = "Title"
            contactInfo.textColor = UIColor.lightGray
        }
        

    }
       
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
