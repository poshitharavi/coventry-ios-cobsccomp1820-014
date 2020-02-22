//
//  RegisterViewController.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/19/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    //text box variables
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileNumberTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    //image views
    @IBOutlet weak var checkConfirmPasswordImg: UIImageView!
    
    //activity indicator 
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //text type event
        passwordTxt.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: UIControl.Event.editingChanged)
        
        confirmPasswordTxt.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChanged(_ textfield:UITextField){
        guard let password = passwordTxt.text else {return}
        
        //un hide the image before check
        if textfield == confirmPasswordTxt {
            checkConfirmPasswordImg.isHidden = false
        }else{
            if password.isEmpty{//if password txt is empty or cleared hide image and clear confirm password
              checkConfirmPasswordImg.isHidden = true
                confirmPasswordTxt.text = ""
            }
        }
        
        //check the password and confirm password is mathing or not
        if passwordTxt.text != confirmPasswordTxt.text {
            //set error image to image views in both
            checkConfirmPasswordImg.image = UIImage(named: ImageFiles.ErrorIcon)
        }else {
            checkConfirmPasswordImg.isHidden = true
        }
    }
    
    
    //register button acction
    @IBAction func registerBtn(_ sender: Any) {
    
        //varibale initilizing with null check
        guard let email = emailTxt.text, email.isNotEmpty ,
            let name = nameTxt.text, name.isNotEmpty ,
            let password = passwordTxt.text , password.isNotEmpty ,
            let mobileNumber = mobileNumberTxt.text, mobileNumber.isNotEmpty else {return }
        
        activityIndicator.startAnimating()//start the animator when the button is clicked and the input values are correct
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                debugPrint(error)
                return
            }
            
            self.activityIndicator.stopAnimating() //stop the animator
            print("Registered successfully" )
        }
        
    }
    

}
