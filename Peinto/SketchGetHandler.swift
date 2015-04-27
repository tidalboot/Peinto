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
    
    public func getSketches (numberOfSketchesToReturn: Int, fromDate: String, toDate: String, callback: (sketches: NSMutableArray, errorOccured: Bool) -> ()) {
        let apiPath = "http://peinto.org/api/sketch?numberofSketches=\(numberOfSketchesToReturn)&toDate=\(toDate)&fromDate=\(fromDate)"
        let api = NSURL(string: apiPath)
        let apiSession = NSURLSession.sharedSession()
        
        let getDataTask = apiSession.dataTaskWithURL(api!,
            completionHandler: {(data, response, error) -> Void in
                println("\(error)")
                if error != nil {
                    return callback(sketches: [], errorOccured: true)
                }
                var sketches: NSMutableArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSMutableArray
                return callback(sketches: sketches, errorOccured: false)
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
    
    func parseImageLinksFromSketchArray (arrayOfSketches: NSMutableArray) -> NSMutableArray {
        var arrayToReturn: NSMutableArray = []
        
        for sketch in arrayOfSketches {
            var sketchString = sketch["Url"] as! String
            println("\(sketchString)")
            sketchString = sketchString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            var sketchURL = NSURL(string: sketchString)
            println("\(sketchURL)")
            arrayToReturn.addObject(sketchURL!)
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