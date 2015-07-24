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
    
        :param: callback The callback function
    */
    public func fetchLoggedInUser(callback:(user: User?, error: Error?) -> Void) {
        Alamofire
            .request(UserRouter.ReadUser())
            .responseJSON(options: nil, completionHandler: {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
                if (error != nil) {
                    println("error: \(error)")
                }
                if (JSON != nil) {
                    if let rawObject = JSON as? [String:AnyObject]{
                        if let id = rawObject["id"] as? Int{
                            let wuser = User(rawUser: rawObject)
                            callback(user: wuser, error: nil)
                        }
                        else if let error = rawObject["error"] as? [String:AnyObject]{
                            let werror = Error(rawError: error)
                            callback(user: nil, error: werror)
                        }
                    }
                    else {
                        println("json: \(JSON)")
                    }
                }
            })
    }
    
}
