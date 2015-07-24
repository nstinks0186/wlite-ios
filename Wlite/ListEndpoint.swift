//
//  ListEndpoint.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation
import Alamofire

public class ListEndpoint {
    
    public func fetchLoggedInUserLists(callback:(lists: [List]?, error: Error?) -> Void) {
        Alamofire
            .request(ListRouter.ReadLists())
            .responseJSON(options: nil) {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
                if (error != nil) {
                    println("error: \(error)")
                }
                if (JSON != nil) {
                    if let rawLists  = JSON as? [[String:AnyObject]] {
                        var lists = [List]()
                        for rawList in rawLists {
                            lists.append(List(rawList: rawList))
                        }
                        callback(lists: lists, error: nil)
                    }
                    else if let rawObject = JSON as? [String:AnyObject]{
                        if let error = rawObject["error"] as? [String:AnyObject]{
                            let werror = Error(rawError: error)
                            if werror.isAuthenticationError {
                                Wlite.updateAccessToken(nil)
                            }
                            callback(lists: nil, error: werror)
                        }
                    }
                }
        }
    }
    
}

