//
//  HomeViewController.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/19/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    @IBOutlet var homeTableView: UITableView!
    
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
