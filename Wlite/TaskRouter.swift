//
//  TaskRouter.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation
import Alamofire

public enum TaskRouter: URLRequestConvertible {
    static var OAuthToken: String?
    static var ClientID: String?
    
    case ReadTasks()
    case CreateTask([String: AnyObject])
    case ReadTask(String)
    case UpdateTask(String)
    case DeleteTask(String)
    
    var method: Alamofire.Method {
        switch self {
        case .ReadTasks:
            return .GET
        case .CreateTask:
            return .POST
        case .ReadTask:
            return .GET
        case .UpdateTask:
            return .PATCH
        case .DeleteTask:
            return .DELETE
        }
    }
    
    var path: String {
        switch self {
        case .ReadTasks():
            return "/tasks"
        case .CreateTask:
            return "/tasks"
        case .ReadTask(let taskid):
            return "/tasks/\(taskid)"
        case .UpdateTask(let taskid):
            return "/tasks/\(taskid)"
        case .DeleteTask(let taskid):
            return "/tasks/\(taskid)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    public var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: WunderlistAPIBaseURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if (TaskRouter.OAuthToken != nil && TaskRouter.ClientID != nil) {
            // Wunderlist does not support "Authorization: Bearer" as defined in oAuth specs
            // see https://developer.wunderlist.com/documentation/concepts/authorization
            mutableURLRequest.setValue("Bearer \(TaskRouter.OAuthToken)", forHTTPHeaderField: "Authorization")
            mutableURLRequest.setValue(TaskRouter.OAuthToken, forHTTPHeaderField: "X-Access-Token")
            mutableURLRequest.setValue(TaskRouter.ClientID, forHTTPHeaderField: "X-Client-ID")
        }
        else {
            // TODO: handle invalid auth
        }
        
        switch self {
        case .CreateTask(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}