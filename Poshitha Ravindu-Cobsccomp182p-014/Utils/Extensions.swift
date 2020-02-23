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
    
    //custom alert messages for user 
    func customAlert(title : String, msg : String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert,animated: true, completion: nil)
    }
 }
 
 
