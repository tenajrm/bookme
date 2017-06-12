//
//  LoginViewController.swift
//  Bookme
//
//  Created by Janet Rivas on 6/11/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication




class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var isLogging: Bool = false
    
    @IBAction func login(_ sender: Any) {
        if(!isLogging){
            self.performSegue(withIdentifier: "home", sender: nil)
            isLogging = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.addBlurEffect()
        userTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        passwordTextField.delegate = self
    
        
    }
    
    
    /**
     This method will present an UIAlertViewController to inform the user that the device has not a TouchID sensor.
     */
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        
        AlertHelp.showAlert(title:  NSLocalizedString("titleAlert", comment: "title"), message:  NSLocalizedString("noTouchID", comment: "Warnings"))
        
    }
    
   
    /**
     This method will return an error message string for the provided error code.
     The method check the error code against all cases described in the `LAError` enum.
     If the error code can't be found, a default message is returned.
     - parameter errorCode: the error code
     - returns: the error message
     */
    func errorMessageForLAErrorCode( errorCode:Int ) -> String{
        
        var message = ""
        
        switch errorCode {
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
        
    }
    
    /**
     This method will push the authenticated view controller onto the UINavigationController stack
     */
    func navigateToAuthenticatedViewController(){
        if(!isLogging){
            self.performSegue(withIdentifier: "home", sender: nil)
            isLogging = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        isLogging = false
        
        //Create a authentication context
        let authenticationContext = LAContext()
        var error:NSError?
        
        /*Check if the device has a fingerprint sensor
         If not, show the user an alert view and bail out!*/
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
            
        }
        
        // Check the fingerprint
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Please, use your FingerPrint..",
            reply: { [unowned self] (success, error) -> Void in
                if(success) {
                    DispatchQueue.main.async {
                        // Update UI
                        self.navigateToAuthenticatedViewController()
                    }
                }else {
                    // Check if there is an error
                    if let error = error {
                        let message = self.errorMessageForLAErrorCode(errorCode: error._code)
                        print("Error Fingerprint Auth :\(message)")
                        //AlertHelp.showAlert(title:  NSLocalizedString("titleAlert", comment: "title"), message:  message)
                        
                    }
                }
        })

        
    }

    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            let backItem = UIBarButtonItem()
            backItem.title = "Log Out"
            navigationItem.backBarButtonItem = backItem
            _ = segue.destination as! HomeViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
