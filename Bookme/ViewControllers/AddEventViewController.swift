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

class AddEventViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var helper:TableViewHelper!
    
  
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        helper = TableViewHelper(tableView:tableView)
        
        helper.addCell(0, cell: tableView.dequeueReusableCell(withIdentifier: "S0R0")! as UITableViewCell, name: "S0R0")
        helper.addCell(0, cell: tableView.dequeueReusableCell(withIdentifier: "S0R1")! as UITableViewCell, name: "S0R1")
        
        helper.addCell(1, cell: tableView.dequeueReusableCell(withIdentifier: "S1R0")! as UITableViewCell, name: "S1R0")
        
        helper.addCell(2, cell: tableView.dequeueReusableCell(withIdentifier: "S2R0")! as UITableViewCell, name: "S2R0")
        helper.addCell(2, cell: tableView.dequeueReusableCell(withIdentifier: "S2R1")! as UITableViewCell, name: "S2R1")
        helper.addCell(2, cell: tableView.dequeueReusableCell(withIdentifier: "S2R2")! as UITableViewCell, name: "S2R2")
        
        helper.addCell(3, cell: tableView.dequeueReusableCell(withIdentifier: "S3R0")! as UITableViewCell, name: "S3R0")
        
        helper.hideCell("S0R1")
        helper.hideCell("S1R0")
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
        
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return helper.cellForRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let name = helper.cellNameAtIndexPath(indexPath) {
            switch name {
            case "S0R0":
                if !helper.cellIsVisible("S0R1") {
                    helper?.showCell("S0R1")
                } else {
                    helper?.hideCell("S0R1")
                }
                
            case "S0R1":
                helper?.hideCell(name)
                
            case "S1R0":
                helper?.showCell("S2R0")
                helper?.showCell("S2R1")
                helper?.showCell("S2R2")
                helper?.hideCell(name)
                
            case "S3R0":
                break
                
            default:
                helper.hideCell(name)
                helper.showCell("S1R0")
            }
            
            if name != "S0R0" {
                helper?.hideCell("S0R1")
            }
        }
    }
    



}


/*class AddEventViewController: UIViewController{

    @IBOutlet weak var addEventTableView: UITableView!
    
    var helper:TableViewHelper!

    @IBAction func actionReserveNavigation(_ sender: Any) {
        
    }
    
    @IBAction func Title(_ sender: Any) {
        print("Editing..")
    }
    
    
    
    var items = ["Title", "Name", "Email", "Phone", "Date", "Special Preferences"]
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        addEventTableView.estimatedRowHeight = 44
        addEventTableView.rowHeight = UITableViewAutomaticDimension
        
        
        helper = TableViewHelper(tableView:addEventTableView)
        
        helper.addCell(0, cell: addEventTableView.dequeueReusableCell(withIdentifier: "S0R0")! as UITableViewCell, name: "S0R0")
        helper.addCell(0, cell: addEventTableView.dequeueReusableCell(withIdentifier: "S0R1")! as UITableViewCell, name: "S0R1")
        
        /*helper.addCell(0, cell: addEventTableView.dequeueReusableCell(withIdentifier: "basicCellID")! as! BasicCellView, name: "BasicCellView")
       
        helper.addCell(0, cell: addEventTableView.dequeueReusableCell(withIdentifier: "dateCellID")! as! DateCellView, name: "DateCellView")
        
        helper.addCell(0, cell: addEventTableView.dequeueReusableCell(withIdentifier: "preferenceCellID")! as! PreferencesTextView, name: "PreferencesTextView")*/
        

        
       /* addEventTableView.register(UINib(nibName: "BasicCellView", bundle: nil), forCellReuseIdentifier: "basicCellID")
        addEventTableView.register(UINib(nibName: "PreferencesTextView", bundle: nil), forCellReuseIdentifier: "preferenceCellID")
        addEventTableView.register(UINib(nibName: "DateCellView", bundle: nil), forCellReuseIdentifier: "dateCellID")*/
        
        helper.hideCell("S0R1")
        helper.hideCell("S1R0")
        
        addEventTableView.dataSource = self
        addEventTableView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension AddEventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = helper.numberOfSections()
        return count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return helper.cellForRowAtIndexPath(indexPath)
        
       /* let element = items[indexPath.row]
        
        switch element  {
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
            cell.contactInfo.text = element
            cell.contactInfo.textColor = UIColor.lightGray
            return cell
        }*/
        
        
        /*let cell = addEventTableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as UITableViewCell
        
        return cell*/
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let name = helper.cellNameAtIndexPath(indexPath) {
            switch name {
            case "S0R0":
                if !helper.cellIsVisible("S0R1") {
                    helper?.showCell("S0R1")
                } else {
                    helper?.hideCell("S0R1")
                }
                
            case "S0R1":
                helper?.hideCell(name)
 
            default:
                helper.hideCell(name)
                helper.showCell("S1R0")
            }
            
            if name != "S0R0" {
                helper?.hideCell("S0R1")
            }
        }

        
        
        
       /* let element  = items[indexPath.row]
            
        if element == "Date" {
           // self.performSegue(withIdentifier: "reservationDetails", sender: nil)
        }*/
            
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Contact Information"
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfSectionsInTableView section: Int) -> Int {
        //return 1
        return helper.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 1 {
            return 193
        }
        
        /*if (indexPath as NSIndexPath).section == 0 &&  indexPath.row == items.count-1 {
            return 100
        }*/
       return tableView.rowHeight
    }
    
   /* func datePickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.medium
        
        let strDate = TimestampHelper.getCurrentTimestamp(timestamp : datePicker.date)
        print("sstrDate \(strDate)")
       
       // let currentCell = addEventTableView.cellForRow(at: self.indexpathCell!) as! ContactCellView
        
        //currentCell.reservationValue.text = strDate
        
        
    }*/
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reservationDetails" {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            _ = segue.destination as! ReservationDetails
        }
    }

}*/





