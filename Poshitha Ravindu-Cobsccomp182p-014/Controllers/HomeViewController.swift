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
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var profileBarBtn: UIBarButtonItem!
    
    //variables
    var events  = [Event]()
    var db : Firestore!
    var listner : ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()//init firestore
        
        //setting delegate and data source
        eventTableView.delegate = self
        eventTableView.dataSource = self
        
        //register the table view
        eventTableView.register(UINib(nibName: Identifiers.eventCellIdentifier, bundle: nil), forCellReuseIdentifier: Identifiers.eventCellIdentifier)
    
    }
 
    //when the view apears
    override func viewDidAppear(_ animated: Bool) {
        
        //fetchDocument()
        fetchCollection()
        
        if let _ = Auth.auth().currentUser{
            signInOutBtn.title = "Sign Out"
            profileBarBtn.isEnabled = true
        }else{
            signInOutBtn.title = "Sign In"
            profileBarBtn.isEnabled = false
        }
    }
    
    //remove listner when the view is hidden
    override func viewWillDisappear(_ animated: Bool) {
        listner.remove()
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
    
    
    func fetchDocument(){
        let docRef = db.collection("Events").document("PTbow3qSREnAFd5vyyCN")
        
        
        listner =  docRef.addSnapshotListener { (snap, error) in
            self.events.removeAll()
            guard let data = snap?.data() else {return}
            let newEvent = Event.init(data: data)
            self.events.append(newEvent)
            self.eventTableView.reloadData()
        }
        
//        docRef.getDocument { (snap, error) in
//            guard let data = snap?.data() else{return}
//
//            let event = Event.init(data: data)
//
//            self.events.append(event)
//            self.eventTableView.reloadData()
//
//        }
        
    }
    
    func fetchCollection(){
        
        let collectionReference = db.collection("Events")
        
        listner = collectionReference.addSnapshotListener { (snap, error) in
            self.events.removeAll()
            guard let documents = snap?.documents else {return}
            for document in documents{
                let data = document.data()
                let newEvent = Event(data: data)
                self.events.append(newEvent)
                self.eventTableView.reloadData()
            }
        }
        
//        collectionReference.getDocuments { (snap, error) in
//            guard let documents = snap?.documents else {return}
//            for document in documents{
//                let data = document.data()
//                let newEvent = Event(data: data)
//                self.events.append(newEvent)
//                self.eventTableView.reloadData()
//            }
//        }
    }
    
    
}

//initilize delegate and data source
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.eventCellIdentifier , for: indexPath) as? EventTableViewCell {
            cell.configureCell(event: events[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
