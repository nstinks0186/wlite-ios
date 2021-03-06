//
//  UserVC.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 8/7/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import UIKit

class UserVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier {
            let vc = segue.destinationViewController as! ResultVC
            vc.apiTitle = identifier
            switch (identifier) {
            case "fetchLoggedInUser":
                vc.apiFunction = {(callback:ResultVCSuccessCallback)->Void in
                    App.wlite.api.user.fetchLoggedInUser { (user, error) -> Void in
                        if let werror = error{
                            callback(result: werror.message.rawValue, error: true)
                        }
                        else if let wuser = user {
                            callback(result: wuser.userString(), error: false)
                        }
                    }
                    
                }
                return
            case "fetchUsersLoggedInUserCanAccess":
                vc.apiFunction = {(callback:ResultVCSuccessCallback)->Void in
                    App.wlite.api.user.fetchUsersLoggedInUserCanAccess { (users, error) -> Void in
                        if let werror = error{
                            callback(result: werror.message.rawValue, error: true)
                        }
                        else if let wusers = users {
                            // TODO: improve the result string passed in to ResultVC
                            callback(result: "users count: \(wusers.count)", error: false)
                        }
                    }
                    
                }
                return
            default:
                break
            }
        }
        
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

}
