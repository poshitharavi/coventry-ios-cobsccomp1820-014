//
//  ForgotPasswordViewController.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/22/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    //text box
    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //button clicks
    @IBAction func cancelBtnClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPasswordBtnClick(_ sender: Any) {
        
        //get textbox values
        guard let email = emailTxt.text , email.isNotEmpty else {
            customAlert(title: "Error", msg: "Enter the email")
            return
        }
        
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
           
            //check any error in firebase process
            if let error = error {
                
                debugPrint(error)
                self.handleFireAuthError(error: error)
                return
            }
            
            self.dismiss(animated: true, completion: nil)//dissmiss the prompt
        }
    }
    
}
