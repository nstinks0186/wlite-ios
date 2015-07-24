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
    
    public static let appConfig: AppConfig = AppConfig(clientID:"71436ba1a9dc81c908f1", clientSecret:"0974ff4a3fbd2403522a7608c5a227e2e06f8925cdab58fd7a34f8199dc8", authCallbackUrl:"https://dl.dropboxusercontent.com/u/33491043/sites/wlite/success.html")
    
    public static let wlite: Wlite = Wlite(appConfig: App.appConfig)
    
}