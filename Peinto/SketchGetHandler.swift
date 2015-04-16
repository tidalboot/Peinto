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
    
//    public var sketchData: NSObject!
    
    public init () {
        
    }
    
    public func getSketchImages (numberOfSketchesToReturn: Int, callback: (sketches: NSData) -> ()) {
        let apiPath = "http://www.peinto.org/api/sketch?numberofSketches=\(numberOfSketchesToReturn)"
        let api = NSURL(string: apiPath)
        let apiSession = NSURLSession.sharedSession()
        
        let getDataTask = apiSession.dataTaskWithURL(api!,
            completionHandler: {(data, response, error) -> Void in
                var sketches: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSArray
                
//                var sketchArray = []
                
//                for sketch in sketches {
                    var sketchDictionary = sketches[0] as! NSDictionary
                    var sketchString:String  = sketchDictionary["ImageUrl"] as! String
                    var sketchURL = NSURL(string: "\(sketchString)")
//                }
                
                

                
                var sketchToReturn = NSData(contentsOfURL: sketchURL!)
                println("fair enough")
                return callback(sketches: sketchToReturn!)
        })
        
        getDataTask.resume()
    }
    
    
}