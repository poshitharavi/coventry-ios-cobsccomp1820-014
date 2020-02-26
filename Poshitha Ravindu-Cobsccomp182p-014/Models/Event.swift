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
    var participating = [String]()
    var publisherId : String
    
    
    init(
        title:String,
        id : String,
        discription : String,
        location :String,
        publisher : String,
        eventimageUrl: String,
        timeStamp : Timestamp,
        publisherId : String,
        participating : Array<String>) {
        
        
        self.title = title
        self.id = id
        self.discription = discription
        self.eventimageUrl = eventimageUrl
        self.publisher = publisher
        self.publisherId = publisherId
        self.location = location
        self.timeStamp = timeStamp
        self.participating = participating
        
        
    }
    
    init(data :[String : Any]) {
        self.title = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.discription = data["discription"] as? String ?? ""
        self.location = data["location"] as? String ?? ""
        self.publisher = data["publisher"] as? String ?? ""
        self.eventimageUrl = data["eventimageUrl"] as? String ?? ""
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        self.publisherId = data["publisherId"] as? String ?? ""
        self.participating = (data["participating"] as? Array ?? nil) ?? [""]
    }
    
    static func modelToData(event : Event) -> [String:Any]{// set the event data to dictionaty
        
        let data : [String : Any] = [
            "discription" : event.discription,
            "id" : event.id,
            "eventimageUrl" : event.eventimageUrl,
            "location": event.location,
            "name": event.title,
            "publisher": event.publisher,
            "publisherId": event.publisherId,
            "timeStamp": event.timeStamp,
            "participating": event.participating
            
        ]
        return data
    }
}
