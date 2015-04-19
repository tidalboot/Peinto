//va
//  SketchCollectionViewController.swift
//  Peinto
//
//  Created by Nick Jones on 05/04/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import UIKit

class SketchCollectionViewController: UICollectionViewController {

    let sketchGetHandler = SketchGetHandler()
    private let cellReuseIdentifier = "SketchCell"
    var numberOfCellsToLoad = 0
    var numberOfSketchesToLoad = 3
    var newIndexPath = 0
    var lastDate = ""
    var returnedSketches: NSData!
    var imageDataToUse: NSMutableArray!
    var imageArray: NSMutableArray = []
    
    override func viewDidLoad() {
        sketchGetHandler.getSketches(3, fromDate: lastDate, callback: updateImageArray)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
//            numberOfSketchesToLoad = numberOfSketchesToLoad + 3
            sketchGetHandler.getSketches(3, fromDate: lastDate, callback: updateImageArray)
        }
    }

    
    func updateImageArray (sketches: NSMutableArray) {
        lastDate = sketchGetHandler.getLastDateFromSketchArray(sketches)
//        println("\(lastDate)")
        imageDataToUse = sketchGetHandler.parseImagesFromSketchArray(sketches)
        imageArray.addObject(imageDataToUse[0])
        imageArray.addObject(imageDataToUse[1])
        imageArray.addObject(imageDataToUse[2])

        numberOfCellsToLoad = numberOfCellsToLoad + imageDataToUse.count
        println("\(imageArray.count)")
     
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.collectionView!.reloadData()
        })
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCellsToLoad
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let sketchCell = collectionView.dequeueReusableCellWithReuseIdentifier("sketchCell", forIndexPath: indexPath) as! SketchCell
        let sketchCell = collectionView.dequeueReusableCellWithReuseIdentifier("sketchCell", forIndexPath: indexPath) as! SketchCell
        
//        if newIndexPath > imageArray.count {
//            newIndexPath = newIndexPath - 1
//        }
        
        println("\(newIndexPath)")
//        if newIndexPath > 2 {
//            newIndexPath = 0
//        }
        
        indexPath.item

        sketchCell.sketchView.image = UIImage(data: imageArray[indexPath.item] as! NSData)
        newIndexPath++

        return sketchCell
    }
}
