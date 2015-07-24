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
    
    public var URLRequest: NSURLRequest {
        let URL = NSURL(string: WunderlistAPIBaseURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = AvatarRouter.OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        case .ReadAvatar(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}

