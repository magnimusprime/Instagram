//
//  PostViewController.swift
//  instagram
//
//  Created by Maggie Gates on 3/6/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var displayedImageView: UIImageView?
    @IBOutlet weak var captionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            let image = originalImage
            
            let size = CGSize(width: 320, height: 320)
            displayedImageView!.image = resize(editedImage, newSize: size)

            dismissViewControllerAnimated(true, completion: nil)
            
    }

       @IBAction func onLibrary(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }

    
    @IBAction func onCamera(sender: AnyObject) {
    
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
  
    @IBAction func onPost(sender: AnyObject) {
        
        //let newImage = resize(displayedImageView!.image!, newSize: CGSize(width: 300, height: 500))
        
        Post.postUserImage(displayedImageView!.image, withCaption: captionTextField.text!) { (success: Bool, error: NSError?) -> Void in
            print("Photo Posted")
        }
     self.performSegueWithIdentifier("backSegue", sender: nil )
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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