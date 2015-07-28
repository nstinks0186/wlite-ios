//
//  ListEndpoint.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

//func readLists()
//func readList(listid: Int)
//func createListWithTitle(title: String)
//func updateList(listid: Int, withRevision revision: Int, publicflag ispublic: Bool)
//func deleteList(listid: Int, withRevision revision: Int)

import Foundation
import Alamofire

public class ListEndpoint {
    
    /**
        Get all Lists a user has permission to
        
    
        :param: callback The callback function
    */
    public func fetchLoggedInUserLists(callback:(lists: [List]?, error: Error?) -> Void) {
        Alamofire
            .request(ListRouter.ReadLists())
            .responseJSON(options: nil) {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
                if (error != nil) {
                    println("error: \(error)")
                }
                else if (JSON != nil) {
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
                    else {
                        println("json: \(JSON)")
                    }
                }
                else {
                    println("response: \(response!.description)")
                }
        }
    
    }
    
    /**
        Get a specific List
    
        :param: listid The id of list
        :param: callback The callback function
    */
    public func fetchList(listid:Int, callback:(list: List?, error: Error?) -> Void) {
        Alamofire
            .request(ListRouter.ReadList("\(listid)"))
            .responseJSON(options: nil) {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
                if (error != nil) {
                    println("error: \(error)")
                }
                else if (JSON != nil) {
                    if let rawObject = JSON as? [String:AnyObject] {
                        if let error = rawObject["error"] as? [String:AnyObject]{
                            let werror = Error(rawError: error)
                            if werror.isAuthenticationError {
                                Wlite.updateAccessToken(nil)
                            }
                            callback(list: nil, error: werror)
                        }
                        else if let id = rawObject["id"] as? Int{
                            let list = List(rawList: rawObject)
                            callback(list: list, error: nil)
                        }
                        else {
                            println("JSON: \(JSON)")
                        }
                    }
                }
                else {
                    println("response: \(response!.description)")
                }
        }
    }
    
    /**
        Create a List
    
        :param: list The list to be created
        :param: callback The callback function
    */
    public func createList(list:List, callback:(list: List?, error: Error?) -> Void) {
        let parameters : [ String : AnyObject] = ["title": list.title]
        Alamofire
            .request(ListRouter.CreateList(parameters))
            .responseJSON(options: nil) {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
                if (error != nil) {
                    println("error: \(error)")
                }
                else if (JSON != nil) {
                    if let rawObject = JSON as? [String:AnyObject] {
                        if let error = rawObject["error"] as? [String:AnyObject]{
                            let werror = Error(rawError: error)
                            if werror.isAuthenticationError {
                                Wlite.updateAccessToken(nil)
                            }
                            callback(list: nil, error: werror)
                        }
                        else if let id = rawObject["id"] as? Int{
                            list.update(rawObject)
                            callback(list: list, error: nil)
                        }
                        else {
                            println("JSON: \(JSON)")
                        }
                    }
                }
                else {
                    println("response: \(response!.description)")
                }
        }
    }
    
    /**
    Update a list by overwriting properties
    
    :param: list The list
    :param: callback The callback function
    */
    public func updateList(list:List, callback:(list: List?, error: Error?) -> Void) {
        let parameters : [ String : AnyObject] = [
            "id": list.id,
            "revision": list.revision,
            "title": list.title
        ]
        Alamofire
            .request(ListRouter.UpdateList(parameters))
            .responseJSON(options: nil) {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
                if (error != nil) {
                    println("error: \(error)")
                }
                else if (JSON != nil) {
                    if let rawObject = JSON as? [String:AnyObject] {
                        if let error = rawObject["error"] as? [String:AnyObject]{
                            let werror = Error(rawError: error)
                            if werror.isAuthenticationError {
                                Wlite.updateAccessToken(nil)
                            }
                            callback(list: nil, error: werror)
                        }
                        else if let id = rawObject["id"] as? Int{
                            list.update(rawObject)
                            callback(list: list, error: nil)
                        }
                        else {
                            println("JSON: \(JSON)")
                        }
                    }
                }
                else {
                    println("response: \(response!.description)")
                }
        }
    }
    
    
}

