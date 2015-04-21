//va
//  SketchCollectionViewController.swift
//  Peinto
//
//  Created by Nick Jones on 05/04/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import UIKit

class SketchCollectionViewController: UICollectionViewController {



    @IBOutlet var homeButton: UIBarButtonItem!
    
    let sketchGetHandler = SketchGetHandler()
    private let cellReuseIdentifier = "SketchCell"
    var numberOfCellsToLoad = 0
    var oldestDate = ""
    var newestDate = ""
    var imageArray: NSMutableArray = []
    var dateArray: NSMutableArray = []
    var heartArray: NSMutableArray = []
    var webLinkArray: NSMutableArray = []
    var downloadAllowed = true
    
    var index: NSMutableArray = []
    
    override func viewDidLoad() {
        sketchGetHandler.getSketches(3, fromDate: "", toDate: oldestDate, callback: addSketches)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > scrollView.contentSize.height - (scrollView.frame.size.height) * 2 && downloadAllowed) {
            downloadAllowed = false
            sketchGetHandler.getSketches(3, fromDate: "", toDate: oldestDate, callback: addSketches)
        }
        //---Shelved until API has been updated---
        //Feature 1a
    }
    
        //---Shelved until API has been updated---
        //Feature 1b
    
    func addSketches (sketches: NSMutableArray) {
        oldestDate = sketchGetHandler.getLastDateFromSketchArray(sketches)
        newestDate = sketchGetHandler.getNewestDateFromSketchArray(sketches)
        heartArray.addObjectsFromArray(sketchGetHandler.parseHeartsFromSketchArray(sketches) as [AnyObject])
        dateArray.addObjectsFromArray(sketchGetHandler.parseDatesFromSketchArray(sketches) as [AnyObject])
        imageArray.addObjectsFromArray(sketchGetHandler.parseImagesFromSketchArray(sketches) as [AnyObject])
        webLinkArray.addObjectsFromArray(sketchGetHandler.parseImageLinksFromSketchArray(sketches) as [AnyObject])
        
        numberOfCellsToLoad = numberOfCellsToLoad + sketches.count
     
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.collectionView!.reloadData()
            self.downloadAllowed = true
            self.homeButton.enabled = true
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

        sketchCell.sketchView.image = UIImage(data: imageArray[indexPath.item] as! NSData)
        sketchCell.dateCreatedLabel.text = "Created \(dateArray[indexPath.item])"
        sketchCell.heartLabel.text = "Hearts: \(heartArray[indexPath.item])"
        sketchCell.webLink = webLinkArray[indexPath.item] as! NSURL
        
        index.addObject(indexPath)
        
        return sketchCell
    }
    
    @IBAction func homeButton(sender: AnyObject) {
        self.collectionView!.scrollToItemAtIndexPath(index[0] as! NSIndexPath, atScrollPosition: UICollectionViewScrollPosition.Top, animated: true)
    }

}
