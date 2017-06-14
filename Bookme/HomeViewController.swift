//
//  ViewController.swift
//  Bookme
//
//  Created by Janet Rivas on 6/10/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController, UITableViewDelegate {

    var reservarionListData = [ReservationModel]()
  

    @IBAction func addEvent(_ sender: Any) {
        self.performSegue(withIdentifier: "addEvent", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 234.0/255.0, green: 87.0/255.0, blue: 76.0/255.0, alpha: 1);
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white ]
        
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
        print("You tapped cell number \(indexPath.row).")
        
    }
    
    
    //Number of sections in table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    


    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addEvent" {
            let backItem = UIBarButtonItem()
            backItem.title = "Cancel"
            navigationItem.backBarButtonItem = backItem
            _ = segue.destination as! AddEventViewController
        }
    }
    
    
    
    
    


}

