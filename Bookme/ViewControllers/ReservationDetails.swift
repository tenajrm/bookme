//
//  ReservationDetails.swift
//  Bookme
//
//  Created by Janet Rivas on 6/15/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import Foundation
import UIKit

class ReservationDetails: UIViewController {
    
   var reservatioItem: ReservationModel!
    
    
    @IBOutlet weak var guessNAme: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet var parentView: UIView!
    
    @IBOutlet weak var markFullButton: UIButton!
    
    @IBAction func markAsFull(_ sender: Any) {
        
        RealmService.updateObject(updateObjet: reservatioItem, isFull : true)
        AlertHelp.showAlert(title:  NSLocalizedString("titleAlert", comment: "title"), message: NSLocalizedString("messageFull", comment: "messageFull") )
    }
    
    
    
    @IBAction func confirmationCall(_ sender: Any) {
        
        let phone = String(reservatioItem.phoneNumber)
        
        if let phoneCallURL = URL(string: "telprompt://\(phone)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        
    }
    
   
    @IBAction func shareMyBooking(_ sender: Any) {
        //open the database and change to full
        let shareText = "My teable in Bookme!! "
    
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: [ ])
        
        activityViewController.excludedActivityTypes = [UIActivityType.assignToContact, UIActivityType.print, UIActivityType.saveToCameraRoll]
        activityViewController.popoverPresentationController?.sourceView = self.parentView
        activityViewController.popoverPresentationController?.sourceRect = self.parentView.bounds
        
        present(activityViewController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessNAme.text = reservatioItem.name
        phoneNumber.text = String(reservatioItem.phoneNumber)
        email.text = reservatioItem.email
        dateLabel.text = TimestampHelper.getCurrentTimestamp(timestamp: reservatioItem.reservationDate, isSystemformat: false)
        
        if reservatioItem.isFull {
             markFullButton.isHidden = true
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
