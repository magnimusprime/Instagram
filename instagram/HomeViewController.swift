//
//  HomeViewController.swift
//  instagram
//
//  Created by Maggie Gates on 3/6/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var postTableView: UITableView!
    var photos: [PFObject]?
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        postTableView.insertSubview(refreshControl, atIndex: 0)
        
        postTableView.dataSource = self
        postTableView.delegate = self
        self.parseAPICall()
        postTableView.reloadData()
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return photos?.count ?? 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        
        let photo = photos![indexPath.row]
    
        cell.photoView.file = photo["media"] as? PFFile
        cell.photoView.loadInBackground()
        
        let caption = photo ["caption"] as! String
        cell.postCaptionTextView.text = caption
        
        
        
        return cell
        
    }
    
    
    func parseAPICall() {
        
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
               
                print("photos pulled")
                self.photos = posts
                self.postTableView.reloadData()
            } else {
                
                print (error?.localizedDescription)
            }
        }
    }
   
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.postTableView.reloadData()
        self.parseAPICall()
        refreshControl.endRefreshing()
    }
    

}

