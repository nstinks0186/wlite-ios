//
//  AuthVC.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import UIKit
import Wlite

class AuthVC: UIViewController {
    
    var wlite:Wlite!

    override func viewDidLoad() {
        super.viewDidLoad()

        wlite = App.wlite
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Methods
    
    @IBAction func authenticateButtonTapped(sender: AnyObject) {
        
        wlite.authorize({ (token) -> Void in
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            });
        }, failureHandler: { (error) -> Void in
            println("error: \(error)")
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
