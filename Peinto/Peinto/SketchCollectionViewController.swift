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
    var returnedSketches: NSData!
    var imageDataToUse: NSMutableArray!
    
    override func viewDidLoad() {
        sketchGetHandler.getSketches(14, callback: updateImageArray)
    }

    func updateImageArray (sketches: NSMutableArray) {
        imageDataToUse = sketchGetHandler.parseImagesFromSketchArray(sketches)
        println("\(imageDataToUse.count)")
        numberOfCellsToLoad = imageDataToUse.count
        
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
        
        println("\(indexPath)")
        sketchCell.sketchView.image = UIImage(data: imageDataToUse[indexPath.item] as! NSData)
        
        return sketchCell
    }
}
