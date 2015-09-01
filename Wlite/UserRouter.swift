//
//  UserRouter.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation
import Alamofire

public enum UserRouter: URLRequestConvertible {
    static var OAuthToken: String?
    
    case ReadUser()
    case ReadUsers()
    
    var method: Alamofire.Method {
        switch self {
        case .ReadUser:
            return .GET
        case .ReadUsers:
            return .GET
        }
    }

    var path: String {
        switch self {
        case .ReadUser():
            return "/user"
        case .ReadUsers():
            // TODO: implement optional parameter `list_id` (https://developer.wunderlist.com/documentation/endpoints/user)
            return "/users"
        }
    }
    
    // MARK: URLRequestConvertible
    
    public var URLRequest: NSURLRequest {
        let URL = NSURL(string: WunderlistAPIBaseURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = UserRouter.OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        default:
            return mutableURLRequest
        }
    }
}