//
//  File.swift
//  Bookme
//
//  Created by Janet Rivas on 6/15/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//


import UIKit

class DatePickerCellView: UITableViewCell {
    
    @IBOutlet weak var datePickerCom: UIDatePicker!
   
     var dataPicker: UIDatePicker!
    
    @IBAction func pickerValueChange(_ sender: UIDatePicker, forEvent event: UIEvent) {
        
        print("\(sender.date)")
        dataPicker = sender
    
    }
    
    
    func getSender() -> UIDatePicker {
        return dataPicker
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

