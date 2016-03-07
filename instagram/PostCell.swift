//
//  PostCell.swift
//  instagram
//
//  Created by Maggie Gates on 3/6/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class PostCell: UITableViewCell {
    
    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet weak var postCaptionTextView: UITextView!
   
    
  /*  var instagramPost: PFObject! {
        didSet {
            self.photoView.file = instagramPost["image"] as? PFFile
            self.photoView.loadInBackground()
        }
    } */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
