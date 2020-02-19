//
//  GuestViewController.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/19/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class GuestViewController: UITableViewController {
    
    @IBOutlet var guestViewTable: UITableView!
    
    let eventlist = [
        
        Event(title: "Event One", discription: "Test event make by me", location: "Wanniya", publisher: "Poshitha Ravindu", eventimageName: "event_pic_1"),
        Event(title: "Event Two", discription: "Test event make by me", location: "Colombo", publisher: "Poshitha Warnapala", eventimageName: "event_pic_2"),
        Event(title: "Event 3", discription: "මමයි හාදුඅෛ ායු ාුල දා", location: "No ware", publisher: "Rumesh Chandima", eventimageName: "event_pic_3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guestViewTable.delegate = self
        guestViewTable.dataSource = self
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventlist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "guestEventCell", for: indexPath) as? GuestTableViewCell {
            cell.setDataToCell(event: eventlist[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 365
    }

   

}
