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
        setupTabelViews()
        
    }
    
    func setupTabelViews() {
        //setting delegate and data source
        eventTableView.delegate = self
        eventTableView.dataSource = self
        
        //register the table view
        eventTableView.register(UINib(nibName: Identifiers.eventCellIdentifier, bundle: nil), forCellReuseIdentifier: Identifiers.eventCellIdentifier)
    }
 
    //when the view apears
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = Auth.auth().currentUser{
            signInOutBtn.title = "Sign Out"
            profileBarBtn.isEnabled = true
        }else{
            signInOutBtn.title = "Sign In"
            profileBarBtn.isEnabled = false
        }
        
        setEventListner()//Initilizing the listner
    }
    
    //remove listner when the view is hidden
    override func viewWillDisappear(_ animated: Bool) {
        listner.remove()//removing the listner when view is disappear
        events.removeAll()//remove all the data in the array
        eventTableView.reloadData()//reload the table view
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
    
    
    func setEventListner() {//document listner
        
        listner = db.homeEvents.addSnapshotListener({ (snap, error) in
            if let error = error{
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let event = Event.init(data: data)
                
                switch change.type{//checking the change mode
                case .added:
                    self.onEventAdded(change: change, event: event)
                case .modified:
                    self.onEventModified(change: change, event: event)
                case .removed:
                    self.onEventRemoved(change: change)
                }
            })
        })
    }
}

//initilize delegate and data source
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func onEventAdded(change : DocumentChange, event : Event){//event added
        
        let newIndex = Int(change.newIndex)
        events.insert(event, at: newIndex)
        eventTableView.insertRows(at: [IndexPath(item: newIndex, section: 0)], with: .none)
    }
    
    func onEventModified(change : DocumentChange, event : Event) {//event modified
        
        if change.newIndex == change.oldIndex {//if the previous index is same as the current index
            
            let index = Int(change.newIndex)
            events[index] = event
            eventTableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .none)
            
        }else{//the item index has been changed from the prevous index
            
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            
            events.remove(at: oldIndex)
            events.insert(event, at: newIndex)
            
            eventTableView.moveRow(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
            
        }
    }
    
    func onEventRemoved(change : DocumentChange){//event removed
        let oldIndex = Int(change.oldIndex)
        events.remove(at: oldIndex)
        eventTableView.deleteRows(at: [IndexPath(item: oldIndex, section: 0)], with: .fade)
    }
    
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
        return 450
    }
}
