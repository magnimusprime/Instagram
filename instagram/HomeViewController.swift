//
//  HomeViewController.swift
//  instagram
//
//  Created by Maggie Gates on 3/6/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogoutButton(sender: AnyObject) {
        // PFUser.currentUser() will now be nil
        PFUser.logOut()
        let LoginViewController = storyboard!.instantiateViewControllerWithIdentifier("LoginViewController");
        self.presentViewController(LoginViewController, animated:true, completion:nil);
        print("Logged Out!")
       
    }

}

