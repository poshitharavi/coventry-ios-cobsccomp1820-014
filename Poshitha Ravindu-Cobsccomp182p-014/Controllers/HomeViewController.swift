//
//  HomeViewController.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/19/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import Firebase


class HomeViewController: UITableViewController {

    //table view
    @IBOutlet var homeTableView: UITableView!
    
    //button
    @IBOutlet weak var signInOutBtn: UIBarButtonItem!
    
    
    
    
    let eventlist = [
    
        Event(title: "Event One", discription: "Test event make by me", location: "Wanniya", publisher: "Poshitha Ravindu", eventimageName: "event_pic_1"),
        Event(title: "Event Two", discription: "Test event make by me", location: "Colombo", publisher: "Poshitha Warnapala", eventimageName: "event_pic_2"),
        Event(title: "Event 3", discription: "මමයි හාදුඅෛ ායු ාුල දා", location: "No ware", publisher: "Rumesh Chandima", eventimageName: "event_pic_3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventlist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell {
            cell.setDataToCell(event: eventlist[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
