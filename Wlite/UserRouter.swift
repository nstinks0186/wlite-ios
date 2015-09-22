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
    static var ClientID: String?
    
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
    
    public var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: WunderlistAPIBaseURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if (UserRouter.OAuthToken != nil && UserRouter.ClientID != nil) {
            // Wunderlist does not support "Authorization: Bearer" as defined in oAuth specs
            // see https://developer.wunderlist.com/documentation/concepts/authorization
            mutableURLRequest.setValue("Bearer \(UserRouter.OAuthToken)", forHTTPHeaderField: "Authorization")
            mutableURLRequest.setValue(UserRouter.OAuthToken, forHTTPHeaderField: "X-Access-Token")
            mutableURLRequest.setValue(UserRouter.ClientID, forHTTPHeaderField: "X-Client-ID")
        }
        else {
            // TODO: handle invalid auth 
        }
        
        switch self {
        default:
            return mutableURLRequest
        }
    }
}