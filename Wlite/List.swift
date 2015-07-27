//
//  List.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation

public enum ListType : String {
    case List = "list"
    case Inbox = "inbox"
}

public class List : Object{
    public var title = ""
    public var listType : ListType = .List
    
    convenience init (id:Int, revision:Int, title:String){
        self.init(id: id, revision: revision)
        self.title = title
    }
    
    convenience init (rawList: [String:AnyObject]) {
        let id = rawList["id"] as! Int
        let revision = rawList["revision"] as! Int
        let title = rawList["title"] as! String
        let listType = rawList["list_type"] as! String
        
        self.init(id: id, revision: revision)
        self.title = title
        self.listType = (listType == "inbox" ? .Inbox : .List)
    }
    
}
