//
//  App.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation
import Wlite

public class App {
    
    public static var wlite: Wlite!
    
}

extension Object {
    func objectString() -> String {
        return "id: \(self.id)"
            + "\nrevision: \(self.revision)"
    }
}

extension User {
    func userString() -> String {
        return super.objectString() +
            "\nname: \(self.name)" +
            "\nemail: \(self.email)"
    }
}
