//
//  AlertViewController.swift
//  Bookme
//
//  Created by Janet Rivas on 6/11/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import Foundation


import Foundation
import UIKit

protocol AlertViewControllerDelegate {
    func SubmitAlertViewResult(userName : String)
}


class AlertViewController {
    
    static let sharedInstance = AlertViewController()
    
    private init(){}
    
    var delegate : AlertViewControllerDelegate?
    
    func SubmitAlertView(viewController : UIViewController,title : String, message : String){
        
        let alert = UIAlertController(title: title, message: message,preferredStyle: .alert)
        
        // Submit button
        let submitAction = UIAlertAction(title: NSLocalizedString("alertSubmit", comment: "submit"), style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let textField = alert.textFields![0]
            
            if(textField.text != "")
            {
                self.delegate?.SubmitAlertViewResult(userName: textField.text!)
            }
            
        })
        
        // Cancel button
        let cancel = UIAlertAction(title: NSLocalizedString("alertCancel", comment: "cancel"), style: .destructive, handler: { (action) -> Void in })
        
        
        // Add 1 textField and cutomize it
       /* alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = NSLocalizedString("userNamePlaceHolder", comment: "userName")
            textField.clearButtonMode = .whileEditing
        }*/
        
        // Add action buttons and present the Alert
        alert.addAction(submitAction)
        alert.addAction(cancel)
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
}
