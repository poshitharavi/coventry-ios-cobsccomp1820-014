//
//  User.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/19/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import Foundation

struct User {
    var name:String
    var id : String
    var email:String
    var contactnumber:Int
    var facebooklink:String
    var profilepicUrl:String
    
    
    init(data :[String : Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.contactnumber = data["contactnumber"] as? Int ?? 0
        self.facebooklink = data["facebooklink"] as? String ?? ""
        self.profilepicUrl = data["profilepicUrl"] as? String ?? ""
    }
}
