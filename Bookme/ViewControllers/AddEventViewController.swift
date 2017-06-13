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
    
     var items = ["Name", "Email", "Phone", "Special Request"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEventTableView.dataSource = self
        addEventTableView.delegate = self
        
        addEventTableView.register(UINib(nibName: "ContactCellView", bundle: nil), forCellReuseIdentifier: "ContactCellID")
        
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
    
        // Trying to reuse a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCellID", for: indexPath) as! ContactCellView
    
        cell.reservationLabel.text = element
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

