//
//  SketchGetHandler.swift
//  Peinto
//
//  Created by Nick Jones on 04/04/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import Foundation
import UIKit

public class SketchGetHandler {
        
    public init () {
        
    }
    
    public func getSketches (numberOfSketchesToReturn: Int, callback: (sketches: NSMutableArray) -> ()) {
        let apiPath = "http://www.peinto.org/api/sketch?numberofSketches=\(numberOfSketchesToReturn)"
        let api = NSURL(string: apiPath)
        let apiSession = NSURLSession.sharedSession()
        
        let getDataTask = apiSession.dataTaskWithURL(api!,
            completionHandler: {(data, response, error) -> Void in
                var sketches: NSMutableArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSMutableArray
                return callback(sketches: sketches)
        })
        getDataTask.resume()
    }
    
    public func parseImagesFromSketchArray (arrayOfSketches: NSMutableArray) -> NSMutableArray {
        var arrayToReturn: NSMutableArray = []
        
        for sketch in arrayOfSketches {
            var sketchString:String  = sketch["ImageUrl"] as! String
            var sketchURL = NSURL(string: "\(sketchString)")
            var sketchImageAsData = NSData(contentsOfURL: sketchURL!)
            arrayToReturn.addObject(sketchImageAsData!)
        }
        println("\(arrayToReturn.count)")
        return arrayToReturn
    }
    
    
}