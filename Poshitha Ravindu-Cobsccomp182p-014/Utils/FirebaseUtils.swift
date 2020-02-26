//
//  FirebaseUtils.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/23/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import Firebase

extension Firestore {
    
    var events : Query {//get all events
        return collection("Events")
    }
    
    var homeEvents : Query {//get all events order by the time stamp usefull to home page
        return collection("Events").order(by: "timeStamp", descending: true)
    }
    
    var users : Query {//user colleaction
        return collection("Users")
    }
    
    func userByEmail(email : String) -> Query {
        return collection("Users").whereField("email", isEqualTo: email)
    }
    
    func UserAddedEvents(userId : String) -> Query { //get the user added events to my events
        return collection("Events").whereField("publisherId", isEqualTo: userId).order(by: "timeStamp", descending: true)
    }
}

extension Auth {
    
    //error handling with firebase and view a alert box
    func handleFireAuthError(error: Error, viewController : UIViewController){
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            viewController.present(alert,animated: true,completion: nil)
        }
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
