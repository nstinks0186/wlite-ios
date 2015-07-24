//
//  AppConfig.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation

public struct AppConfig {
    public var clientID : String
    public var clientSecret : String
    public var authCallbackUrl : String
    
    public init(clientID:String, clientSecret:String, authCallbackUrl:String){
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.authCallbackUrl = authCallbackUrl
    }
}