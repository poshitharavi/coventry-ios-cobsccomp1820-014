//
//  GuestTableViewCell.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/20/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class GuestTableViewCell: UITableViewCell {

    //label views
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var discriptionLbl: UILabel!
    
    //button
    @IBOutlet weak var userNamaBtn: UIButton!
    
    //image view
    @IBOutlet weak var eventImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDataToCell(event: Event){
        
        eventNameLbl.text = event.title
        locationLbl.text = event.location
        discriptionLbl.text = event.discription
        userNamaBtn.setTitle(event.publisher, for: .normal)//setting text to button
        eventImage.image = UIImage(named: event.eventimageName)//setting image name
        
    }

}
