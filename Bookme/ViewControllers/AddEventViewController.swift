//
//  AddEventViewController.swift
//  Bookme
//
//  Created by Janet Rivas on 6/11/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import UIKit
//import RealmSwift
import Foundation
import DatePickerCell

class AddEventViewController: UIViewController{

    @IBOutlet weak var addEventTableView: UITableView!

    @IBAction func actionReserveNavigation(_ sender: Any) {
        
    }
    
    @IBAction func Title(_ sender: Any) {
        print("Editing..")
    }
    
    
    //var modalState = false;
     var items:NSArray = []
    //var items = ["Title", "Name", "Email", "Phone", "Date", "Special Preferences"]
    
     override func viewDidLoad() {
        super.viewDidLoad()
        addEventTableView.dataSource = self
        addEventTableView.delegate = self
        
        addEventTableView.estimatedRowHeight = 44
        addEventTableView.rowHeight = UITableViewAutomaticDimension
        
        addEventTableView.register(UINib(nibName: "BasicCellView", bundle: nil), forCellReuseIdentifier: "basicCellID")
        addEventTableView.register(UINib(nibName: "PreferencesTextView", bundle: nil), forCellReuseIdentifier: "preferenceCellID")
        addEventTableView.register(UINib(nibName: "DateCellView", bundle: nil), forCellReuseIdentifier: "dateCellID")
        
        // The DatePickerCell.
        let datePickerCell = DatePickerCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        // Cells is a 2D array containing sections and rows.
        items = [["Title"], ["Name"], ["Email"], ["Phone"], ["Date"], ["Special Preferences"], [datePickerCell]]
        


        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension AddEventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let section = items[indexPath.section] as! NSArray
        let element = items[indexPath.row]
        
        if element is String {
            
            let elementString  = element as! String
        
        switch elementString  {
        case "Date":
            let cell = addEventTableView.dequeueReusableCell(withIdentifier: "dateCellID", for: indexPath) as! DateCellView
            //reuse a cell
            cell.detailTextLabel?.text = TimestampHelper.getCurrentTimestamp(timestamp: Date())
            
            cell.detailTextLabel?.textColor =  UIColor.init(red: 234.0/255.0, green: 87.0/255.0, blue: 76.0/255.0, alpha: 1);
            
            return cell
            
        case "Special Preferences":
            //Custom cell
            let cell = addEventTableView.dequeueReusableCell(withIdentifier: "preferenceCellID", for: indexPath) as! PreferencesTextView
            cell.preferencesTextView.text = "Special Preferences"
            cell.preferencesTextView.textColor = UIColor.lightGray
            
            return cell
            
            
        default:
            let cell = addEventTableView.dequeueReusableCell(withIdentifier: "basicCellID", for: indexPath) as! BasicCellView
            cell.contactInfo.text = elementString
            cell.contactInfo.textColor = UIColor.lightGray
            return cell
        }
    }
        
    if element is DatePickerCell {
        
        
        let section = items[indexPath.section] as! NSArray
        let elementArray = section[indexPath.row]  as! UITableViewCell

        // Getting the right element
        if elementArray is DatePickerCell {
            return element[indexPath.row]
        }
        }
        
        let cell = addEventTableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as UITableViewCell
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        // Getting the right element
        let section = items[indexPath.section] as! NSArray
        let dateCell = section[indexPath.row]
        
        if dateCell is DatePickerCell {
            let cell = addEventTableView.cellForRow(at: indexPath)
            if let datePickerCell = cell as? DatePickerCell {
                datePickerCell.selectedInTableView(tableView)
                tableView.deselectRow(at: indexPath, animated: true)
            }

        }
        
        if dateCell is String {
            let element  = section[indexPath.row] as! String
            
            if element == "Date" {
                self.performSegue(withIdentifier: "reservationDetails", sender: nil)
            }

        }
            
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Contact Information"
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfSectionsInTableView section: Int) -> Int {
        return 1//(items[section] as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        let cell = addEventTableView.cellForRow(at: indexPath)
        if let datePickerCell = cell as? DatePickerCell {
            return datePickerCell.datePickerHeight()
        }
    
        if indexPath.row == items.count-1 {
            return 100
        }
        return 44
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.medium
        
        let strDate = TimestampHelper.getCurrentTimestamp(timestamp : datePicker.date)
        print("sstrDate \(strDate)")
       
       // let currentCell = addEventTableView.cellForRow(at: self.indexpathCell!) as! ContactCellView
        
        //currentCell.reservationValue.text = strDate
        
        
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reservationDetails" {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            _ = segue.destination as! ReservationDetails
        }
    }

}





