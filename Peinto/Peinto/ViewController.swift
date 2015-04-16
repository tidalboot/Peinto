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
        sketchGetHandler.getSketchImages(1, callback: sketchViewUpdate)
    }
    
    func sketchViewUpdate (sketch: NSData) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.sketchImage.image = UIImage(data: sketch)
        })
    }

    

}

