//
//  Event.swift
//  Poshitha Ravindu-Cobsccomp182p-014
//
//  Created by Poshitha Adikari on 2/19/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Event {
    var title:String
    var id : String
    var discription:String
    var location:String
    var publisher: String
    var eventimageUrl:String
    var timeStamp : Timestamp
    
    
    init(data :[String : Any]) {
        self.title = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.discription = data["discription"] as? String ?? ""
        self.location = data["location"] as? String ?? ""
        self.publisher = data["publisher"] as? String ?? ""
        self.eventimageUrl = data["eventimageUrl"] as? String ?? ""
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
}
