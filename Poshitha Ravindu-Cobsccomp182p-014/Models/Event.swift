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
    var publisher:String
    var eventimageUrl:String
    var timeStamp : Timestamp
}
