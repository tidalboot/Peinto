//
//  SketchCellHandler.swift
//  Peinto
//
//  Created by Nick Jones on 17/04/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import UIKit

class SketchCell: UICollectionViewCell {
    @IBOutlet var sketchView: UIImageView!
    @IBOutlet var dateCreatedLabel: UILabel!
    @IBOutlet var heartLabel: UILabel!
    @IBOutlet var webLinkButton: UIButton!
    
    var webLink: NSURL!
    
    
    @IBAction func openLink(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(webLink)
    }

}
