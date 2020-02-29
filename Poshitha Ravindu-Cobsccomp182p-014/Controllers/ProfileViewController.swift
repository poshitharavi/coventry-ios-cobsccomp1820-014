//
//  ProfileViewController.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/23/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class ProfileViewController: UIViewController {

    //labels
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var facebookLinkLbl: UILabel!
    
    //image view
    @IBOutlet weak var profileImgView: UIImageView!
    
    //activity indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //variables
    var db : Firestore!
    var loggedUserId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        loggedUserId = UserDefaults.standard.string(forKey: UserDefaultsId.userIdUserdefault)
        activityIndicator.startAnimating()//start animating in begiing
        
        fetchLoggedUser()//fetch data of user
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchLoggedUser()
    }
    

    func fetchLoggedUser(){
        
        let docRef = db.collection("Users").document(loggedUserId)
        
        docRef.getDocument { (snap, error) in
            guard let data = snap?.data() else{return}
            
            let user = User.init(data: data)
            
            self.setDataToView(user: user)//set the data
            self.activityIndicator.stopAnimating()
        }
    
    }
    
    func setDataToView(user : User) {
        
        nameLbl.text = user.name
        emailLbl.text = user.email
        facebookLinkLbl.text = user.facebooklink
        
        //check mobile number available
        if user.contactnumber != 0{
            mobileNumberLbl.text = String(user.contactnumber)
        }else{
            mobileNumberLbl.text = ""
        }
        
        //set the url to the image view
        if let url = URL(string: user.profilepicUrl){
            profileImgView.kf.setImage(with: url)
        }
        
        
    }

}
