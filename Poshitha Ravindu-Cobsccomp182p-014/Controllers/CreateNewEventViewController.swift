//
//  CreateNewEventViewController.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/26/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class CreateNewEventViewController: UIViewController {

    //text boxes
    @IBOutlet weak var eventNameTxt: UITextField!
    @IBOutlet weak var eventLocationTxt: UITextField!
    @IBOutlet weak var eventDiscriptionTxt: UITextField!
    
    //activity indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //image viewer
    @IBOutlet weak var eventImageView: RoundedImageView!
    
    //variable
    var loggedUserID : String!
    var loggedUserName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loggedUserID = UserDefaults.standard.string(forKey: UserDefaultsId.userIdUserdefault)
        loggedUserName = UserDefaults.standard.string(forKey: UserDefaultsId.userNameUserdefault)
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTap(_:))) //tap event inilize
        tap.numberOfTapsRequired = 1 // set tap count
        eventImageView.isUserInteractionEnabled = true //set user interaction true
        eventImageView.addGestureRecognizer(tap)//set the tap as a gesture to image view
    }
    
    @objc func imgTap(_ tap : UITapGestureRecognizer){//image tap recognizer
        
        launchImagePicker()
    }
    
    @IBAction func eventSubmitButtonClick(_ sender: Any) {
        activityIndicator.startAnimating()
        uploadImageThenDocument()
        
    }
    
    func uploadImageThenDocument(){
        
        //get all the data from text fields and image view
        guard let image = eventImageView.image ,
        let eventName = eventNameTxt.text , eventName.isNotEmpty,
        let eventLocation = eventLocationTxt.text , eventLocation.isNotEmpty,
            let eventDiscription = eventDiscriptionTxt.text , eventDiscription.isNotEmpty else {
                customAlert(title: "Error", msg: "Must fill the all event details")
                return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {return}//conveting to data
        
        let imageRef = Storage.storage().reference().child("/EventImages/\(eventName).jpg")//setting the file location and name
        
        let metaData = StorageMetadata()//set meta data
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
                
                self.uploadDocument(url: url.absoluteString)//upload the event data to the firestore
                
            })
        }
    }
    
    func uploadDocument(url : String) {
        
        var docRef : DocumentReference!
        //set the datato the object
        var event = Event.init(title: eventNameTxt.text ?? "",
                               id: "",
                               discription: eventDiscriptionTxt.text ?? "",
                               location: eventLocationTxt.text ?? "",
                               publisher: loggedUserName,
                               eventimageUrl: url,
                               timeStamp: Timestamp(),
                               publisherId: loggedUserID,
                               participating: [""])
        
        docRef = Firestore.firestore().collection("Events").document()
        event.id = docRef.documentID
        let data = Event.modelToData(event: event)
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

extension CreateNewEventViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchImagePicker(){//launching the media
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker,animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {return}
        eventImageView.contentMode = .scaleAspectFit
        eventImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
