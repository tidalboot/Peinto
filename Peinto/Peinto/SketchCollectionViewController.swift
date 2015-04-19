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
    var currentMaxIndex = 0
    var returnedSketches: NSData!
    var imageDataToUse: NSMutableArray!
    
    override func viewDidLoad() {
        sketchGetHandler.getSketches(3, callback: updateImageArray)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
//            numberOfSketchesToLoad = numberOfSketchesToLoad + 3
            sketchGetHandler.getSketches(3, callback: updateImageArray)
        }
    }

    
    func updateImageArray (sketches: NSMutableArray) {
        imageDataToUse = sketchGetHandler.parseImagesFromSketchArray(sketches)
        println("\(imageDataToUse.count)")
        numberOfCellsToLoad = numberOfCellsToLoad + imageDataToUse.count
     
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
        let sketchCell = collectionView.dequeueReusableCellWithReuseIdentifier("sketchCell", forIndexPath: indexPath) as! SketchCell

        
//        newIndexPath = indexPath.item
        newIndexPath++
        if newIndexPath > 2 {
            newIndexPath = 0
        }
        
//        if newIndexPath > 1 {
//            newIndexPath = indexPath.item - 2
//        }
        
        println("\(newIndexPath)")
        println("\(indexPath.item)")
//        
//        if indexPath.item > currentMaxIndex {
//            currentMaxIndex = indexPath.item
//        }
        sketchCell.sketchView.image = UIImage(data: imageDataToUse[newIndexPath] as! NSData)
        
        return sketchCell
    }
}
