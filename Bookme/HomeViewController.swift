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
    
    let SECTION_HEIGHT = 20.0
    let ROW_HEIGHT = 80
    
    
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
        
        
        
        //tableView
        
        self.reservationTableView.register(UINib(nibName: "ReservationCellView", bundle: nil), forCellReuseIdentifier: "reservationCellID")
        
        reservationTableView.delegate = self
        reservationTableView.dataSource = self
        
    }
    
    func back(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
        //self.navigationController?.popToViewController((self.navigationController?.viewControllers.first)!, animated: true)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        //get all objects from database
        var reservationsRealm = [ReservationModel]()
        reservationsRealm = RealmService.getAllDBObjects() ?? reservationsRealm
        self.reservarionListData = reservationsRealm
        
        self.reservationTableView.reloadData()
        
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
        let reservation = reservarionListData[indexPath.row]
        self.performSegue(withIdentifier: "reservationDetails", sender: reservation)
    }
    
    
    //Number of sections in table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    


    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //Delete reservation
        
        if editingStyle == .delete {
            //TODO create adelegate component
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
        reservationCell.timestampLabel.text =  TimestampHelper.getCurrentTimestamp(timestamp: timestamp, isSystemformat: false )
        let isFull = reservation["isFull"] as! Bool
        let isExpired = reservation["isExpired"] as! Bool
        let isCancelled = reservation["isCancelled"] as! Bool
        
        
        if( isFull || isExpired ||  isCancelled ){
            reservationCell.status.text = "Full"
            reservationCell.status.textColor = Constants.colorBookme.redLight
            
        } else {
            reservationCell.status.text = "Active"
            reservationCell.status.textColor = UIColor.lightGray
        }
        
       
        
        return reservationCell
    }

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(ROW_HEIGHT)
    }

    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(SECTION_HEIGHT)
    }

    
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addEvent" {
            let backItemAdd = UIBarButtonItem()
            backItemAdd.title = "Back"
            navigationItem.backBarButtonItem = backItemAdd
            _ = segue.destination as! AddEventViewController
        }
        
        if segue.identifier == "reservationDetails" {
            let backItemHome = UIBarButtonItem()
            backItemHome.title = "Back"
            navigationItem.backBarButtonItem = backItemHome
            if let toReservationViewController = segue.destination as? ReservationDetails{
                toReservationViewController.reservatioItem = sender as! ReservationModel
            }
        }
        
    }

}

