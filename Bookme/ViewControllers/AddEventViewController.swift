//
//  AddEventViewController.swift
//  Bookme
//
//  Created by Janet Rivas on 6/11/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import UIKit
import Foundation
import TableViewHelper

class AddEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var helper:TableViewHelper!

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func reserveAction(_ sender: Any) {
        
        let reservationObj = ReservationModel()
        
        let cells = self.tableView.visibleCells
    
        
        for cell in cells {
            // get data from cells
            if(cell.reuseIdentifier == "selecDateCell"){
                
                let timestamp = cell.detailTextLabel?.text
                if timestamp != "" {
                    reservationObj.reservationDate =  TimestampHelper.stringToDate(timestamp: timestamp!)
                } else {
                    reservationObj.reservationDate =  Date()
                }
            }
            
            if(cell.reuseIdentifier == "emailCell"){
                let emailCellText = cell as? EmailCellView
                
                if emailCellText?.emailTextField.text == "" {
                    AlertHelp.showAlert(title:  NSLocalizedString("titleAlert", comment: "title"), message: NSLocalizedString("emailRequired", comment: "emailRequired") )
                    return
                
                } else {
                    reservationObj.email = (emailCellText?.emailTextField.text)!
                }
                
            }
            
            if(cell.reuseIdentifier == "nameCell"){
                let nameCellText = cell as? NameCellView
                if (nameCellText?.nameTextFieldCell.text == "") {
                    //alert
                    AlertHelp.showAlert(title:  NSLocalizedString("titleAlert", comment: "title"), message: NSLocalizedString("messageName", comment: "nameEmpty") )
                    return
                } else {
                    reservationObj.name = (nameCellText?.nameTextFieldCell.text)!
                    print("\(String(describing: nameCellText?.nameTextFieldCell.text))")
                }
            }
            
            if(cell.reuseIdentifier == "phoneCell"){
                let phoneCellText = cell as? PhoneCellView
                //No optional value
                if (phoneCellText?.phoneTextCellView.text == "") {
                    //alert 
                    AlertHelp.showAlert(title:  NSLocalizedString("titleAlert", comment: "title"), message: NSLocalizedString("messagePhone", comment: "phoneempty") )
                    return
                } else {
                    let phone : String = (phoneCellText?.phoneTextCellView.text)!
                    let isAllNumber = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
                    
                    guard phone.characters.count == isAllNumber.characters.count else {
                        AlertHelp.showAlert(title:  NSLocalizedString("titleAlert", comment: "title"), message: NSLocalizedString("messagePhoneError", comment: "phoneempty"))
                        return
                    }
                    reservationObj.phoneNumber = Int(phone)!
                }
                
            }
            
            if(cell.reuseIdentifier == "specialRCell"){
                let preferencesCellText = cell as? PreferencesCellView
                reservationObj.specialRequest = (preferencesCellText?.preferencesTextView.text)!
                print("\(String(describing: preferencesCellText?.preferencesTextView.text))")
            }
        }
        
       
        reservationObj.isCancelled = false
        reservationObj.isFull = false
        reservationObj.isExpired = false
        
        RealmService.writeObjects(obj: reservationObj);
        //Sending back 
        self.performSegue(withIdentifier: "home", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cellLabel = self.tableView.cellForRow(at: indexPath)
        let dateString = TimestampHelper.getCurrentTimestamp(timestamp: Date(), isSystemformat: true)
        cellLabel?.detailTextLabel?.isHidden = false
        cellLabel?.detailTextLabel?.text = dateString
        cellLabel?.detailTextLabel?.textColor = UIColor.black
        self.tableView.reloadData()
        
    }

    override func viewDidLoad() {
         super.viewDidLoad()
        
        helper = TableViewHelper(tableView:tableView)
        
        
        helper.addCell(0, cell: tableView.dequeueReusableCell(withIdentifier: "selecDateCell")! as UITableViewCell, name: "selecDateCell")
        helper.addCell(0, cell: tableView.dequeueReusableCell(withIdentifier: "datePickerCell")! as UITableViewCell, name: "datePickerCell")
        
        helper.addCell(1, cell: tableView.dequeueReusableCell(withIdentifier: "nameCell")! as UITableViewCell, name: "nameCell")
        helper.addCell(1, cell: tableView.dequeueReusableCell(withIdentifier: "phoneCell")! as UITableViewCell, name: "phoneCell")
        helper.addCell(1, cell: tableView.dequeueReusableCell(withIdentifier: "emailCell")! as UITableViewCell, name: "emailCell")
        
        helper.addCell(2, cell: tableView.dequeueReusableCell(withIdentifier: "specialRCell")! as UITableViewCell, name: "specialRCell")
        
        helper.hideCell("datePickerCell")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            let backItem = UIBarButtonItem()
            backItem.title = "Log Out"
            navigationItem.backBarButtonItem = backItem
            _ = segue.destination as! HomeViewController
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
                    
                    let cellDatePicker = tableView.dequeueReusableCell(withIdentifier: "datePickerCell") as? DatePickerCellView
                    
                    let dataPicker = cellDatePicker?.datePickerCom
                    let cellLabel = tableView.cellForRow(at: indexPath)!
                    let dateString = TimestampHelper.getCurrentTimestamp(timestamp: (dataPicker?.date)!, isSystemformat: true)
                    cellLabel.detailTextLabel?.text = dateString
                    
            }
                
            case "datePickerCell":
                helper?.hideCell(name)
                
            case "specialRCell":
                
                 let cellPreferences = tableView.cellForRow(at: indexPath) as? PreferencesCellView
                 if(cellPreferences?.preferencesTextView.text == NSLocalizedString("specialRequest", comment: "specialRequest")) {
                    cellPreferences?.preferencesTextView.text = ""
                 } else if (cellPreferences?.preferencesTextView.text == ""){
                    cellPreferences?.preferencesTextView.text =  NSLocalizedString("specialRequest", comment: "specialRequest")
                 }

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
            return NSLocalizedString("contactInfo", comment: "contact info")
        }
        return ""
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

}
