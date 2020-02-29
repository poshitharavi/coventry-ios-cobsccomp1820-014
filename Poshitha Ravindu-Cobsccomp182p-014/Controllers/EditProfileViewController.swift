//
//  EditProfileViewController.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/29/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class EditProfileViewController: UIViewController {

    //image viewer
    @IBOutlet weak var profileImageView: UIImageView!
    
    //textboxes
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var mobileNumberTxt: UITextField!
    @IBOutlet weak var facebookLinkTxt: UITextField!
    
    //activity indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //variables
    var db : Firestore!
    var loggedUserId : String!
    var user : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the firestore db connection
        db = Firestore.firestore()
        //get the user default data
        loggedUserId = UserDefaults.standard.string(forKey: UserDefaultsId.userIdUserdefault)
        
        //set the gesture to image selector
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTap(_:)))
        tap.numberOfTapsRequired = 1 //tap count to the gesture
        profileImageView.isUserInteractionEnabled = true //set image viewer eneble the user interation
        profileImageView.addGestureRecognizer(tap)//set the tap gesture to image viwer
        
        
         activityIndicator.startAnimating()//start animating in begiing
        
        fetchLoggedUser()//fetchData of user
    }
    
    @objc func imgTap(_ tap : UITapGestureRecognizer){//image tap recognizer
        
        launchImagePicker()
    }

    func fetchLoggedUser(){
        
        let docRef = db.collection("Users").document(loggedUserId)
        
        docRef.getDocument { (snap, error) in
            guard let data = snap?.data() else{return}
            
            self.user = User.init(data: data)
            
            self.setDataToView(user: self.user)//set the data
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    func setDataToView(user : User) {
        
        nameTxt.text = user.name
        facebookLinkTxt.text = user.facebooklink
        
        //check mobile number available
        if user.contactnumber != 0{
            mobileNumberTxt.text = String(user.contactnumber)
        }else{
            mobileNumberTxt.text = ""
        }
        
        //set the url to the image view
        if let url = URL(string: user.profilepicUrl){
            profileImageView.kf.setImage(with: url)
        }
        
        
    }
   
    //change the user data
    @IBAction func saveChangesBtnClick(_ sender: Any) {
        activityIndicator.startAnimating()
        uploadEdditedUserImage()
        
    }
    
    func uploadEdditedUserImage(){
        
        guard let image = profileImageView.image,
        let name = nameTxt.text, name.isNotEmpty,
        let mobilenumber = mobileNumberTxt.text, mobilenumber.isNotEmpty,
        let facebookLink = facebookLinkTxt.text, facebookLink.isNotEmpty
        else {
            customAlert(title: "Error", msg: "Must fill the all the details")
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {return} //convert the image to data
        let imageRef = Storage.storage().reference().child("/UserImages/\(name).jpg")//set the firebase cloud storage location and name
        
        let metaData = StorageMetadata() //set meta data
        metaData.contentType = "image/jpg"
        
        //upload the file
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
                self.handleError(error: error, msg: "Unable to upload image")
                return
            }
            
            //get the download url
            imageRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    self.handleError(error: error, msg: "Unable to retrive image url")
                    return
                }
                
                guard let url = url else {return}
                
                self.updateUserData(url: url.absoluteString)//upload the event data to the firestore
                
            })
            
        }
    }
    
    //upload the data to the firesotore
    func updateUserData(url : String){
        
        var docRef : DocumentReference!
        
        let contactNumber = Int(mobileNumberTxt.text ?? "") ?? 0
        
        var updatedUserDetails = User.init(name: nameTxt.text ?? "", id: "", email: user.email, contactnumber: contactNumber, facebooklink: facebookLinkTxt.text ?? "", profilepicUrl: url)
        
        docRef = Firestore.firestore().collection("Users").document(user.id)
        updatedUserDetails.id = user.id
        
        let data = User.modelToData(user: updatedUserDetails)
       
        docRef.setData(data, merge: true) { (error) in
            if let error = error {
                self.handleError(error: error, msg: "Unable to add new event")
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func handleError(error : Error, msg : String){//fucntion in error
        debugPrint(error.localizedDescription)
        self.customAlert(title: "Error", msg: msg)
        self.activityIndicator.stopAnimating()
        
    }
}

extension EditProfileViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func launchImagePicker(){//launching the media
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker,animated: true, completion: nil)
    }
    
    //after picking the media
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {return}
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    //if imge selector cancelled
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
