//
//  EventTableViewCell.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/23/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import Kingfisher

class EventTableViewCell: UITableViewCell {

    //labels
    @IBOutlet weak var eventNameTxt: UILabel!
    @IBOutlet weak var locationTxt: UILabel!
    @IBOutlet weak var discriptionTxt: UILabel!
    
    //image view
    @IBOutlet weak var eventImgView: UIImageView!
    
    //buttons
    @IBOutlet weak var userNameBtn: UIButton!
    @IBOutlet weak var participatingBtn: RoundedButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(event : Event){
        
        //set the values to the labels
        eventNameTxt.text = event.title
        locationTxt.text = event.location
        discriptionTxt.text = event.discription
        userNameBtn.setTitle(event.publisher, for: .normal)
        
        //set the url to the image view
        if let url = URL(string: event.eventimageUrl){
            eventImgView.kf.setImage(with: url)
        }
        
        
    }
    
    //butons actions
    @IBAction func userNameBtnClick(_ sender: Any) {
    }
    
    @IBAction func participatingBtnClick(_ sender: Any) {
    }
    
    
}
