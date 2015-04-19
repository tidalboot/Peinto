//
//  APISketchGetHandler.swift
//  Peinto
//
//  Created by Nick Jones on 04/04/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import Foundation
import XCTest
import Peinto

class SketchGetHandlerTests: XCTestCase {
    
    let sketchGetHandler = SketchGetHandler()
    
    func test_parse_images_from_sketch_array_returns_an_array_of_ns_data_objects () {
    
        var linkArray = ["First Link", "Second Link"]
        var sketchArray: NSMutableArray = [["ImageUrl": "First Link"], ["ImageUrl": "Second Link"]]
        var parsedSketchArray = sketchGetHandler.parseImagesFromSketchArray(sketchArray)
        
            XCTAssertEqual(linkArray, parsedSketchArray, "Expected an array containing \(linkArray) but got \(parsedSketchArray)")
        
    }
    
}





































