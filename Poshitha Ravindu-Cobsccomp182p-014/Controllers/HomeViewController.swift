//
//  HomeViewController.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/19/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import Firebase


class HomeViewController: UIViewController {
    
    //button
    @IBOutlet weak var signInOutBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //when the view apears
    override func viewDidAppear(_ animated: Bool) {
        if let _ = Auth.auth().currentUser{
            signInOutBtn.title = "Sign Out"
        }else{
            signInOutBtn.title = "Sign In"
        }
    }
    
    
    
    //sign in and sign out btn click
    @IBAction func signInOutBtnClick(_ sender: Any) {
        
        //cheking the user login and if logged sign out or if not sign in
        if let _ = Auth.auth().currentUser{
            
            do{
                try Auth.auth().signOut()
                presentLoginController()
            }catch{
                debugPrint(error.localizedDescription)
            }
        }else{
            presentLoginController()
        }
        
    }
    
    
    //open the signin page
    fileprivate func presentLoginController(){
        let storyboard = UIStoryboard(name: Storyboard.LogingStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LogingStroryboardId)
        present(controller, animated: true, completion: nil)
    }
    
    
}
