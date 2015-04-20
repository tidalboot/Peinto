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
    
    public func getSketches (numberOfSketchesToReturn: Int, fromDate: String, toDate: String, callback: (sketches: NSMutableArray) -> ()) {
        let apiPath = "http://www.peinto.org/api/sketch?numberofSketches=\(numberOfSketchesToReturn)&toDate=\(toDate)&fromDate=\(fromDate)"
        println("\(apiPath)")
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
            var sketchString = sketch["ImageUrl"] as! String
            var sketchURL = NSURL(string: sketchString)
            var sketchImageAsData = NSData(contentsOfURL: sketchURL!)
            arrayToReturn.addObject(sketchImageAsData!)
        }
        return arrayToReturn
    }
    
    func parseDatesFromSketchArray (arrayOfSketches: NSMutableArray) -> NSMutableArray {
        var arrayToReturn: NSMutableArray = []
        
        for sketch in arrayOfSketches {
            var sketchDate: NSString = sketch["CreatedDate"] as! String
            sketchDate = sketchDate.substringToIndex(10)
            arrayToReturn.addObject(sketchDate)
        }
        return arrayToReturn
    }
    
    func parseHeartsFromSketchArray (arrayOfSketches: NSMutableArray) -> NSMutableArray {
        var arrayToReturn: NSMutableArray = []
        
        for sketch in arrayOfSketches {
            var sketchHearts = sketch["HeartCount"] as! Int
            arrayToReturn.addObject(sketchHearts)
        }
        
        return arrayToReturn
    }

    
    func getLastDateFromSketchArray (arrayOfSketches: NSMutableArray) -> String {
        var arraySize = arrayOfSketches.count
        var oldestSketch = arrayOfSketches[arraySize - 1] as! NSDictionary
        var dateToReturn = oldestSketch["CreatedDate"] as! String
        
        return dateToReturn
    }
    
    func getNewestDateFromSketchArray (arrayOfSketches: NSMutableArray) -> String {
        var newestSketch = arrayOfSketches[0] as! NSDictionary
        var dateToReturn = newestSketch["CreatedDate"] as! String
        
        return dateToReturn
    }
    
}