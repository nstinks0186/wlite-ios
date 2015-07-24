//
//  Object.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation

public enum ObjectType:String {
    case User = "user"
    case List = "list"
    case Undefined = ""
}

public class Object {
    var id = 0
    var revision = 0
    var type = ObjectType.Undefined
    
    init (id:Int, revision:Int){
        self.id = id
        self.revision = revision
    }
}