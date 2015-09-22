//
//  ListRouter.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation
import Alamofire

public enum ListRouter: URLRequestConvertible {
    static var OAuthToken: String?
    static var ClientID: String?
    
    case ReadLists()
    case CreateList([String: AnyObject])
    case ReadList(String)
    case UpdateList([String: AnyObject])
    case DeleteList(String)
    
    var method: Alamofire.Method {
        switch self {
        case .ReadLists:
            return .GET
        case .CreateList:
            return .POST
        case .ReadList:
            return .GET
        case .UpdateList:
            return .PATCH
        case .DeleteList:
            return .DELETE
        }
    }
    
    var path: String {
        switch self {
        case .ReadLists():
            return "/lists"
        case .CreateList:
            return "/lists"
        case .ReadList(let listid):
            return "/lists/\(listid)"
        case .UpdateList(let parameters):
            let listid = parameters["id"] as! Int
            return "/lists/\(listid)"
        case .DeleteList(let listid):
            return "/lists/\(listid)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    public var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: WunderlistAPIBaseURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if (ListRouter.OAuthToken != nil && ListRouter.ClientID != nil) {
            // Wunderlist does not support "Authorization: Bearer" as defined in oAuth specs
            // see https://developer.wunderlist.com/documentation/concepts/authorization
            mutableURLRequest.setValue("Bearer \(ListRouter.OAuthToken)", forHTTPHeaderField: "Authorization")
            mutableURLRequest.setValue(ListRouter.OAuthToken, forHTTPHeaderField: "X-Access-Token")
            mutableURLRequest.setValue(ListRouter.ClientID, forHTTPHeaderField: "X-Client-ID")
        }
        else {
            // TODO: handle invalid auth
        }
        
        switch self {
        case .CreateList(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .UpdateList(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}