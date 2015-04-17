//
//  ViewController.swift
//  Peinto
//
//  Created by Nick Jones on 04/04/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var sketchImage: UIImageView!
    @IBOutlet var sketchImage2: UIImageView!

    let sketchGetHandler = SketchGetHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        sketchGetHandler.getSketches(1, callback: sketchViewUpdate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func requestedSketch(sender: AnyObject) {
       sketchGetHandler.getSketches(4, callback: sketchViewUpdate)
    }
    
    func sketchViewUpdate (sketches: NSMutableArray) {
        
        var sketchImages = sketchGetHandler.parseImagesFromSketchArray(sketches)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.sketchImage.image = UIImage(data: sketchImages[0] as! NSData)
            self.sketchImage2.image = UIImage(data: sketchImages[1] as! NSData)
        })
    }

    

}

