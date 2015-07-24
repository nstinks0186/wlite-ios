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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (App.wlite.accessToken != nil) {
            Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
                "X-Client-ID": App.appConfig.clientID,
                "X-Access-Token": App.wlite.accessToken!
            ]
            fetchUser()
        } else {
            authenticate()
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
                println("lists: \(lists!)")
            }
        }
    }
    
    private func authenticate() {
        App.wlite.authorize({ (token) -> Void in
            App.wlite.accessToken = token
            Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
                "X-Client-ID": App.appConfig.clientID,
                "X-Access-Token": App.wlite.accessToken!
            ]
        }, failureHandler: { (error) -> Void in
            println("error: \(error)")
        });
    }
    
    private func handleError(werror:Error) {
        if werror.isAuthenticationError {
            App.wlite.accessToken = nil
            self.authenticate()
        }
        else {
            println("error: \(werror)")
        }
    }

}
