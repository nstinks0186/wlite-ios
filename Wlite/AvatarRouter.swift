//
//  AvatarRouter.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation
import Alamofire

public enum AvatarRouter: URLRequestConvertible {
    static var OAuthToken: String?
    static var ClientID: String?
    
    case ReadAvatar([String: AnyObject])
    
    var method: Alamofire.Method {
        switch self {
        case .ReadAvatar:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .ReadAvatar:
            return "/avatar"
        }
    }
    
    // MARK: URLRequestConvertible
    
    public var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: WunderlistAPIBaseURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if (AvatarRouter.OAuthToken != nil && AvatarRouter.ClientID != nil) {
            // Wunderlist does not support "Authorization: Bearer" as defined in oAuth specs
            // see https://developer.wunderlist.com/documentation/concepts/authorization
            mutableURLRequest.setValue("Bearer \(AvatarRouter.OAuthToken)", forHTTPHeaderField: "Authorization")
            mutableURLRequest.setValue(AvatarRouter.OAuthToken, forHTTPHeaderField: "X-Access-Token")
            mutableURLRequest.setValue(AvatarRouter.ClientID, forHTTPHeaderField: "X-Client-ID")
        }
        else {
            // TODO: handle invalid auth
        }
        
        switch self {
        case .ReadAvatar(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
//        default:
//            return mutableURLRequest
        }
    }
}

