//
//  User.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation

public class User : Object {
    public var email = ""
    public var name = ""
    
    public convenience init(rawUser:[String:AnyObject]) {
        let id = rawUser["id"] as! Int
        let revision = rawUser["revision"] as! Int
        self.init(id: id, revision: revision)
        
        if let type = rawUser["type"] as? String {
            self.type = (type == "user" ? .User : .Undefined)
        }
        if let email = rawUser["email"] as? String {
            self.email = email
        }
        if let name = rawUser["name"] as? String {
            self.name = name
        }
        
        //        let createdAt = rawUser["created_at"] as? String
        //        let updatedAt = rawUser["updated_at"] as? String
    }
    
}