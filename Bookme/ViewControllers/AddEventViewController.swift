//
//  AddEventViewController.swift
//  Bookme
//
//  Created by Janet Rivas on 6/11/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

class AddEventViewController: UIViewController{

    @IBOutlet weak var addEventTableView: UITableView!
    
    
    @IBOutlet weak var reservePickerView: UIView!
    
    @IBOutlet weak var reserveNavigationBar: UIBarButtonItem!
    
    @IBAction func actionReserveNavigation(_ sender: Any) {
        if modalState {
            shiftToModal(shifingToModal: false)
        }
    }
    
    @IBOutlet weak var reserveDatePicker: UIDatePicker!
    

    var modalState = false;
    var items = ["Name ", "Email ", "Phone ", "Date "]
    
    var indexpathCell : IndexPath?
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        addEventTableView.dataSource = self
        addEventTableView.delegate = self
        
        addEventTableView.register(UINib(nibName: "ContactCellView", bundle: nil), forCellReuseIdentifier: "ContactCellID")
        shiftToModal(shifingToModal: false)
        reserveDatePicker.addTarget(self, action:#selector(self.datePickerChanged(datePicker:)), for: UIControlEvents.valueChanged)
        
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
        // Getting the right element
        let element = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCellID", for: indexPath) as! ContactCellView
        //reuse a cell
        cell.reservationLabel.text = element
        cell.reservationLabel.textAlignment = .left
        
        if element == "Date " {
            cell.reservationValue.text = TimestampHelper.getCurrentTimestamp(timestamp: Date())
            cell.reservationValue.isEnabled = false
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.indexpathCell = indexPath
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let element = items[indexPath.row]
        if element == "Date " {
            shiftToModal(shifingToModal: true)
        }
            
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard section == 0  else {
            return "Special request"
        }
    
        return "Contact Information"
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    func shiftToModal(shifingToModal isShiftToModal: Bool) {
        if isShiftToModal {
            modalState = true;
            reserveNavigationBar.title = "Select"
            
            reservePickerView.isHidden = false
            reserveDatePicker.isHidden = false
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
            self.navigationItem.setHidesBackButton(true, animated: false)
            view.endEditing(true)

        } else {
            modalState = false;
            reserveNavigationBar.title = "Reserve"
            reservePickerView.isHidden = true
            reserveDatePicker.isHidden = true
            self.navigationItem.setHidesBackButton(false , animated: false)
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear

        }
        
    }
    
    
    func datePickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.medium
        
        let strDate = TimestampHelper.getCurrentTimestamp(timestamp : datePicker.date)
        print("sstrDate \(strDate)")
       
        let currentCell = addEventTableView.cellForRow(at: self.indexpathCell!) as! ContactCellView
        
        currentCell.reservationValue.text = strDate
        
        
    }

}





