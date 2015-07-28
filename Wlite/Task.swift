//
//  Task.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/28/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation

public class Task: Object {
    public var title:String = ""
    public var listId:Int = -1
    
    convenience init (rawTask: [String:AnyObject]) {
        let id = rawTask["id"] as! Int
        let revision = rawTask["revision"] as! Int
        let title = rawTask["title"] as! String
        let listId = rawTask["list_id"] as! Int
        
        self.init(id: id, revision: revision)
        self.title = title
        self.listId = listId
    }
    
    public convenience init(title:String) {
        self.init(id: -1, revision: -1)
        self.title = title
    }
    
    public func update(rawTask: [String:AnyObject]) {
        let id = rawTask["id"] as! Int
        let revision = rawTask["revision"] as! Int
        let title = rawTask["title"] as! String
        let listId = rawTask["list_id"] as! Int
        
        self.id = id
        self.revision = revision
        self.title = title
        self.listId = listId
    }
    
}
