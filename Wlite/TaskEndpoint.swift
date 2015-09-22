//
//  TaskEndpoint.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/28/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation
import Alamofire

public class TaskEndpoint {
    
    /**
    Create a task
    
    - parameter task: The task to be created
    - parameter list: The list the task will be added to
    - parameter callback: The callback function
    */
    public func createTask(task:Task, forList list:List, callback:(task: Task?, error: Error?) -> Void) {
        let params:[String:AnyObject] = ["list_id":list.id,"title":task.title]
        Alamofire
            .request(TaskRouter.CreateTask(params))
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
//                    print("JSON: \(JSON)")
//                    if let rawObject = JSON as? [String:AnyObject]{
//                        if let id = rawObject["id"] as? Int{
//                            task.update(rawObject)
//                            callback(task: task, error: nil)
//                        }
//                        else if let error = rawObject["error"] as? [String:AnyObject]{
//                            let werror = Error(rawError: error)
//                            if werror.isAuthenticationError {
//                                Wlite.updateAccessToken(nil)
//                            }
//                            callback(task: nil, error: werror)
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

