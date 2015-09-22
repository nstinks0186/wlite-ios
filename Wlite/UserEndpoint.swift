//
//  UserEndpoint.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation
import Alamofire

public class UserEndpoint {
    
    /**
        Fetch the currently logged in user
    
        - parameter callback: The callback function
    */
    public func fetchLoggedInUser(callback:(user: User?, error: Error?) -> Void) {
        Alamofire
            .request(UserRouter.ReadUser())
            .responseJSON(options: []) { (_, _, result) -> Void in
                if(result.isSuccess){
                    // TODO: this
                }else{
                    print("error: \(result)")
                }
        }
//            .responseJSON(options: [], completionHandler: {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
//                if (error != nil) {
//                    print("error: \(error)")
//                }
//                else if (JSON != nil) {
//                    if let rawObject = JSON as? [String:AnyObject]{
//                        if let id = rawObject["id"] as? Int{
//                            let wuser = User(rawUser: rawObject)
//                            callback(user: wuser, error: nil)
//                        }
//                        else if let error = rawObject["error"] as? [String:AnyObject]{
//                            let werror = Error(rawError: error)
//                            if werror.isAuthenticationError {
//                                Wlite.updateAccessToken(nil)
//                            }
//                            callback(user: nil, error: werror)
//                        }
//                        else {
//                            print("json: \(JSON)")
//                        }
//                    }
//                    else {
//                        print("json: \(JSON)")
//                    }
//                }
//                else {
//                    print("response: \(response!.description)")
//                }
//            })
    }
    
    /**
        Fetch the users this user can access
        
        - parameter callback: The callback function
    */
    public func fetchUsersLoggedInUserCanAccess(callback:(users: [User]?, error: Error?) -> Void) {
        // TODO: implement optional parameter `list_id` (https://developer.wunderlist.com/documentation/endpoints/user)
        
        Alamofire
            .request(UserRouter.ReadUsers())
            .responseJSON(options: []) { (_, _, result) -> Void in
                if(result.isSuccess){
                    // TODO: this
                }else{
                    print("error: \(result)")
                }
        }
//            .responseJSON(options: [], completionHandler: {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
//                if (error != nil) {
//                    print("error: \(error)")
//                }
//                else if (JSON != nil) {
//                    if let rawArray = JSON as? [[String:AnyObject]]{
//                        var users = [User]();
//                        for rawObject in rawArray {
//                            if let id = rawObject["id"] as? Int {
//                                let wuser = User(rawUser: rawObject)
//                                users.append(wuser)
//                            }
//                            else {
//                                print("json: \(JSON)")
//                                break;
//                            }
//                        }
//                        callback(users: users, error: nil)
//                    }
//                    else if let rawObject = JSON as? [String:AnyObject]{
//                        if let error = rawObject["error"] as? [String:AnyObject]{
//                            let werror = Error(rawError: error)
//                            if werror.isAuthenticationError {
//                                Wlite.updateAccessToken(nil)
//                            }
//                            callback(users: nil, error: werror)
//                        }
//                        else {
//                            print("json: \(JSON)")
//                        }
//                    }
//                    else {
//                        print("json: \(JSON)")
//                    }
//                }
//                else {
//                    print("response: \(response!.description)")
//                }
//            })
    }
    
}
