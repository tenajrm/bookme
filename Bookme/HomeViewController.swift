//
//  ViewController.swift
//  Bookme
//
//  Created by Janet Rivas on 6/10/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import UIKit
import Foundation


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var reservarionListData = [ReservationModel]()
    
  
    
    @IBOutlet var reservationTableView: UITableView!

    
    @IBAction func addEvent(_ sender: Any) {
        self.performSegue(withIdentifier: "addEvent", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation Bar
        self.navigationController?.navigationBar.barTintColor = Constants.colorBookme.redLight
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white ]
        
        //get all objects from database
        var reservationsRealm = [ReservationModel]()
        reservationsRealm = RealmService.getAllDBObjects() ?? reservationsRealm
        self.reservarionListData = reservationsRealm
        
        //tableView
        
        self.reservationTableView.register(UINib(nibName: "ReservationCellView", bundle: nil), forCellReuseIdentifier: "reservationCellID")
        
        reservationTableView.delegate = self
        reservationTableView.dataSource = self
        
    }
    
    func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    // MARK: - Tableview delegates
    
    //Numbers of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.reservarionListData.count > 0){
            return self.reservarionListData.count
        } else {
            return 0
        }
    }
    
   
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       /* let cell = tableView.cellForRow(at: indexPath) as! ReservationTableViewCell
        cell.backgroundColor = UIColor.lightGray*/
        
    }
    
    
    //Number of sections in table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    


    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //Delete reservation
        
        if editingStyle == .delete {
            
            let removeAlert = UIAlertController(title: NSLocalizedString("titleAlert", comment: "title") , message: NSLocalizedString("messageDelete", comment: "message"), preferredStyle: UIAlertControllerStyle.alert)
            
                removeAlert.addAction(UIAlertAction(title:  NSLocalizedString("alertDelete", comment: "Delete") , style: .destructive, handler: { (action: UIAlertAction!) in
                
                RealmService.removeObject(obj : self.reservarionListData[indexPath.row])
                
                // remove the item from the data model
                self.reservarionListData.remove(at: indexPath.row)
                
                // delete the table view row
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }))
            
            removeAlert.addAction(UIAlertAction(title: NSLocalizedString("alertCancel", comment: "Cancel") , style: .cancel, handler: { (action: UIAlertAction!) in
                //don't do nothing
            }))
            
            present(removeAlert, animated: true, completion: nil)

        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reservationCell = tableView.dequeueReusableCell(withIdentifier: "reservationCellID", for: indexPath) as! ReservationTableViewCell
        
        let reservation : ReservationModel = self.reservarionListData[indexPath.row]
        let name = reservation["name"]
        
        let timestamp = reservation["reservationDate"] as! Date
        
        reservationCell.nameLabel.text = name as? String
        reservationCell.timestampLabel.text =  TimestampHelper.getCurrentTimestamp(timestamp: timestamp )
        let isFull = reservation["isFull"] as! Bool
        let isExpired = reservation["isExpired"] as! Bool
        let isCancelled = reservation["isCancelled"] as! Bool
        
        if( isFull || isExpired ||  isCancelled ){
            reservationCell.status.text = "Deactive"
            reservationCell.status.textColor = Constants.colorBookme.redLight
             reservationCell.imageCustomCell.backgroundColor = UIColor.lightGray
            
        } else {
            reservationCell.status.text = "Active"
            reservationCell.status.textColor = UIColor.lightGray
        }
        
       
        
        return reservationCell
    }

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }

    
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addEvent" {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            _ = segue.destination as! AddEventViewController
        }
    }

}

