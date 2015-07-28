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
    case Task = "task"
    case Undefined = ""
}

public class Object {
    public var id = 0
    public var revision = 0
    public var type = ObjectType.Undefined
    
    init (id:Int, revision:Int){
        self.id = id
        self.revision = revision
    }
}