//
//  MyEventViewController.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/25/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import Firebase

class MyEventViewController: UIViewController {

    //tabel view
    @IBOutlet weak var myEventsTableView: UITableView!
    
    //variables
    var myEvents = [Event]()
    var db : Firestore!
    var listner : ListenerRegistration!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()//init firestore
        setUptableView()
    }
    
    func setUptableView(){
        //setting delegets and data source
        myEventsTableView.delegate = self
        myEventsTableView.dataSource = self
        
        //register the table view
        myEventsTableView.register(UINib(nibName: Identifiers.eventCellIdentifier, bundle: nil), forCellReuseIdentifier: Identifiers.eventCellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setMyEventListner()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        listner.remove()
        myEvents.removeAll()
        myEventsTableView.reloadData()
    }
    
    func setMyEventListner(){
        
        listner = db.events.whereField("publisherId", isEqualTo: "vZOhudqZ42KcS6W78E0L").addSnapshotListener({ (snap, error) in
            if let error = error {
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

extension MyEventViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func onEventAdded(change : DocumentChange, event : Event){//event added
        
        let newIndex = Int(change.newIndex)
        myEvents.insert(event, at: newIndex)
        myEventsTableView.insertRows(at: [IndexPath(item: newIndex, section: 0)], with: .none)
    }
    
    func onEventModified(change : DocumentChange, event : Event) {//event modified
        
        if change.newIndex == change.oldIndex {//if the previous index is same as the current index
            
            let index = Int(change.newIndex)
            myEvents[index] = event
            myEventsTableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .none)
            
        }else{//the item index has been changed from the prevous index
            
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            
            myEvents.remove(at: oldIndex)
            myEvents.insert(event, at: newIndex)
            
            myEventsTableView.moveRow(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
            
        }
    }
    
    func onEventRemoved(change : DocumentChange){//event removed
        let oldIndex = Int(change.oldIndex)
        myEvents.remove(at: oldIndex)
        myEventsTableView.deleteRows(at: [IndexPath(item: oldIndex, section: 0)], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.eventCellIdentifier, for: indexPath) as? EventTableViewCell {
            cell.configureCell(event: myEvents[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
}