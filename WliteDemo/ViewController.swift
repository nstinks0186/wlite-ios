//
//  ViewController.swift
//  WliteDemo
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import UIKit
import Alamofire
import Wlite

class ViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    
    let completionHandler = {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
        if (error != nil) {
            print("error: \(error)")
            print("response: \(response)")
        }
        if (JSON != nil) {
            print("result: \(JSON!)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (App.wlite.accessToken == nil) {
            self.navigationController?.performSegueWithIdentifier("showAuthVC", sender: self)
        } else {
            self.fetchUser()
            self.testAPICalls()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Methods

    @IBAction func fetchListButtonTapped(sender: AnyObject) {
        self.fetchLists()
    }
    
    // MARK: - Convenience Methods
    
    private func fetchUser() {
        App.wlite.api.user.fetchLoggedInUser { (user, error) -> Void in
            if let werror = error{
                print("\(werror)")
//                self.handleError(werror)
            }
            else if let wuser = user {
                self.userLabel.text = "\(wuser.name) | \(wuser.email)"
            }
        }
    }
    
    private func fetchLists() {
        App.wlite.api.list.fetchLoggedInUserLists { (lists, error) -> Void in
            if let werror = error {
                print("\(werror)")
//                self.handleError(werror)
            }
            else {
                print("lists: \(lists!.count)")
                for list:List in lists! {
                    print("  \(list.id) | \(list.title.capitalizedString) | \(list.listType.rawValue) ")
                }
            }
        }
    }
    
    private func authenticate() {
        App.wlite.authorize({ (token) -> Void in
            self.fetchUser()
            self.testAPICalls()
        }, failureHandler: { (error) -> Void in
            print("error: \(error)")
        });
    }
    
    private func testAPICalls() {
//        self.fetchLists()
        
        
        
        
        // Get a specific List
//        { (Void) -> Void in
//            let list = List(id: 141552880)
//            App.wlite.api.list.fetchList(list) { (_, error)  in
//                if let werror = error {
//                    self.handleError(werror)
//                }
//                else {
//                    println("fetched list: \(list.id) | \(list.title)")
//                }
//            }
//        }()
        
        
        // Create a list
//        { (Void) -> Void in
//            let newlist = List(title:"NewList")
//            App.wlite.api.list.createList(newlist) { (_, error)  in
//                if let werror = error {
//                    self.handleError(werror)
//                }
//                else {
//                    println("new list: \(newlist.id) | \(newlist.title.capitalizedString) | \(newlist.listType.rawValue) ")
//                }
//            }
//        }()
        
        
        func testUpdateList () {
            let newlist = List(title:"NewList")
            App.wlite.api.list.createList(newlist) { (list, error) -> Void in
                if let werror = error {
                    print("\(werror)")
//                    self.handleError(werror)
                }
                else if let _ = list {
                    print("new list: \(newlist.id) | \(newlist.title.capitalizedString) | \(newlist.listType.rawValue) ")
                    
                    let updatedList = newlist
                    updatedList.title = "UpdatedList"
                    App.wlite.api.list.updateList(updatedList, callback: { (list, error) -> Void in
                        if let werror = error {
                            print("\(werror)")
//                            self.handleError(werror)
                        }
                        else {
                            print("updated list: \(updatedList.id) | \(updatedList.title.capitalizedString) | \(updatedList.listType.rawValue) ")
                            
                        }
                    })
                }
            }
        }
//        testUpdateList()
        
        func testCreateTask() {
            let list = List(id: 104379923)
            let newtask = Task(title: "blah")
            App.wlite.api.task.createTask(newtask, forList: list) { (task, error) -> Void in
                if let werror = error {
                    print("\(werror)")
//                    self.handleError(werror)
                }
                else {
                    print("new task: \(newtask.id) | \(newtask.title)")
                }
            }
        }
//        testCreateTask()
        
        
    }
    
//    private func handleError(werror:Wlite.Error) {
//        if werror.isAuthenticationError {
//            self.authenticate()
//        }
//        else {
//            print("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
//        }
//    }

}

