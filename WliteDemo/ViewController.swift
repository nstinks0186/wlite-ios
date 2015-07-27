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
            println("error: \(error)")
            println("response: \(response)")
        }
        if (JSON != nil) {
            println("result: \(JSON!)")
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
                self.handleError(werror)
            }
            else if let wuser = user {
                self.userLabel.text = "\(wuser.name) | \(wuser.email)"
            }
        }
    }
    
    private func fetchLists() {
        App.wlite.api.list.fetchLoggedInUserLists { (lists, error) -> Void in
            if let werror = error {
                self.handleError(werror)
            }
            else {
                println("lists: \(lists!.count)")
                for list:List in lists! {
                    println("  \(list.id) | \(list.title.capitalizedString) | \(list.listType.rawValue) ")
                }
            }
        }
    }
    
    private func fetchList(listid:Int) {
        App.wlite.api.list.fetchList(listid, callback: { (list, error) -> Void in
            if let werror = error {
                self.handleError(werror)
            }
            else if let wlist = list {
                println("list: \(wlist.id) | \(wlist.title.capitalizedString) | \(wlist.listType.rawValue) ")
            }
        })
    }
    
    private func createListWithTitle(listtitle:String){
        let newlist = List(title:listtitle)
        App.wlite.api.list.createList(newlist, callback: { (list, error) -> Void in
            if let werror = error {
                self.handleError(werror)
            }
            else if let wlist = list {
                println("new list: \(newlist.id) | \(newlist.title.capitalizedString) | \(newlist.listType.rawValue) ")
            }
        })
    }
    
    private func authenticate() {
        App.wlite.authorize({ (token) -> Void in
            self.fetchUser()
            self.testAPICalls()
        }, failureHandler: { (error) -> Void in
            println("error: \(error)")
        });
    }
    
    private func testAPICalls() {
//        self.fetchLists()
//        self.fetchList(141552880)
        self.createListWithTitle("TestList")
    }
    
    private func handleError(werror:Error) {
        if werror.isAuthenticationError {
            self.authenticate()
        }
        else {
            println("error: \(werror)")
        }
    }

}

