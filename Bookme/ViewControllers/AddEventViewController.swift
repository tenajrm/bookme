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
import TableViewHelper

class AddEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var helper:TableViewHelper!

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func reserveAction(_ sender: Any) {
        
        let emailTextCell = tableView.dequeueReusableCell(withIdentifier: "emailCell") as? EmailCellView
        
        let email = emailTextCell?.emailTextField
        let text = emailTextCell?.getText()
        
        print("EMAIL\(String(describing: email?.text)) and \(String(describing: text))")
      
        self.performSegue(withIdentifier: "reservationDetails", sender: nil)
        
    }
    
    override func viewDidLoad() {
        helper = TableViewHelper(tableView:tableView)
        
        helper.addCell(0, cell: tableView.dequeueReusableCell(withIdentifier: "selecDateCell")! as UITableViewCell, name: "selecDateCell")
        helper.addCell(0, cell: tableView.dequeueReusableCell(withIdentifier: "datePickerCell")! as UITableViewCell, name: "datePickerCell")
        
        helper.addCell(1, cell: tableView.dequeueReusableCell(withIdentifier: "nameCell")! as UITableViewCell, name: "nameCell")
        helper.addCell(1, cell: tableView.dequeueReusableCell(withIdentifier: "phoneCell")! as UITableViewCell, name: "phoneCell")
        helper.addCell(1, cell: tableView.dequeueReusableCell(withIdentifier: "emailCell")! as UITableViewCell, name: "emailCell")
        
        helper.addCell(3, cell: tableView.dequeueReusableCell(withIdentifier: "specialRCell")! as UITableViewCell, name: "specialRCell")
        
        helper.hideCell("datePickerCell")
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reservationDetails" {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            //_ = segue.destination as! ReservationDetails
        }
    }



    func numberOfSections(in tableView: UITableView) -> Int {
        let count = helper.numberOfSections()
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helper.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 1 {
            return 193
        }
        
        if helper.cellNameAtIndexPath(indexPath) ==  "specialRCell" {
            return 150
        }
        
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return helper.cellForRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let name = helper.cellNameAtIndexPath(indexPath) {
            switch name {
            case "selecDateCell":
                if !helper.cellIsVisible("datePickerCell") {
                    helper?.showCell("datePickerCell")
                } else {
                    //Hidde the picker
                    helper?.hideCell("datePickerCell")
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = DateFormatter.Style.medium
                    dateFormatter.timeStyle = DateFormatter.Style.medium
                    
                    let cellDatePicker = tableView.dequeueReusableCell(withIdentifier: "datePickerCell") as? DatePickerCellView
                    
                    let dataPicker = cellDatePicker?.datePickerCom
                    let cellLabel = tableView.cellForRow(at: indexPath)!
                    
                    let dateString = TimestampHelper.getCurrentTimestamp(timestamp: (dataPicker?.date)!)
                    cellLabel.detailTextLabel?.text = dateString
                    cellLabel.detailTextLabel?.textColor = UIColor.black
                    
                }
                
            case "datePickerCell":
                helper?.hideCell(name)
                
            case "specialRCell":
                break
                
            default:
                print("default")
            }
            
            if name != "selecDateCell" {
                helper?.hideCell("datePickerCell")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 1 {
            return "Contact Information"
        }
        return ""
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

}
