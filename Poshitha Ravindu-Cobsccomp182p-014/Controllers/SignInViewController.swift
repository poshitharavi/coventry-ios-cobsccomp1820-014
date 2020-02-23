//
//  SignInViewController.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/19/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    //text boxes
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    //activity indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    //sign in button action
    @IBAction func signInBtn(_ sender: Any) {
        
        //get text inputs and check nullbulles
        guard let email = emailTxt.text, email.isNotEmpty ,
        let password = passwordTxt.text, password.isNotEmpty
        else {
            customAlert(title: "Error", msg: "Please fill out all fields.")
            return
            
        }
        
        activityIndicator.startAnimating()//start the animation when button is clicked
        
        //firebase auth for loging
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, viewController:  self!)//set the extention toncheck firebase validation
                self?.activityIndicator.stopAnimating()
                return
            }
            self?.activityIndicator.stopAnimating()//stop the animation
            self?.dismiss(animated: true, completion: nil)
            
        }
    }
 
    
    //forgot password button action
    @IBAction func forgotPasswordBtn(_ sender: Any) {
        
        let forgotPasswordVC = ForgotPasswordViewController()
        forgotPasswordVC.modalTransitionStyle = .crossDissolve
        forgotPasswordVC.modalPresentationStyle = .overCurrentContext
        present(forgotPasswordVC,animated: true, completion: nil)
    }
    
}
