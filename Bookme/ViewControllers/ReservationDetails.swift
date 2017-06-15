//
//  ReservationDetails.swift
//  Bookme
//
//  Created by Janet Rivas on 6/15/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import Foundation
import DatePickerCell

class ReservationDetails: UITableViewController {
    
    var cells:NSArray = []
    
    override func viewDidLoad() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        
        // The DatePickerCell.
        let datePickerCell = DatePickerCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        // Cells is a 2D array containing sections and rows.
        cells = [[datePickerCell]]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Get the correct height if the cell is a DatePickerCell.
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        if let datePickerCell = cell as? DatePickerCell {
            return datePickerCell.datePickerHeight()
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect automatically if the cell is a DatePickerCell.
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        if let datePickerCell = cell as? DatePickerCell {
            datePickerCell.selectedInTableView(tableView)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cells[section] as AnyObject).count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = cells[indexPath.section] as! NSArray
        return section[indexPath.row] as! UITableViewCell
    }
}
