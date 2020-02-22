 //
//  Extensions.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/22/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
 import Firebase

 extension String {
    //check the null values
    var isNotEmpty : Bool {
        return !isEmpty
    }
 }
 
 
 extension UIViewController {
    //error handling with firebase and view a alert box
    func handleFireAuthError(error: Error){
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert,animated: true,completion: nil)
        }
    }
    
    //custom alert messages for user 
    func customAlert(title : String, msg : String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert,animated: true, completion: nil)
    }
 }
 
 extension AuthErrorCode {
    
    var errorMessage : String {
        
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password or email is incorrect."
            
        default:
            return "Sorry, something went wrong."
        }

    }
 }
