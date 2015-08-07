//
//  ResultVC.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 8/7/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import UIKit

typealias ResultVCSuccessCallback = (result: String, error:Bool) -> Void
typealias ResultVCApiFunction = (callback:ResultVCSuccessCallback) -> Void

class ResultVC: UIViewController {
    
    var apiTitle:String?
    var apiFunction:ResultVCApiFunction?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.apiTitle != nil {
            self.navigationItem.title = self.apiTitle!
        }
        
        if self.apiFunction != nil {
            self.apiFunction!(callback: { (result, error) -> Void in
                if error {
                    self.textView.text = "Error: \n\(result)"
                } else {
                    self.textView.text = "\(result)"
                }
                self.activityIndicator.stopAnimating()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
