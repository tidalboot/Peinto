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
    let scrollHandler = ScrollHandler()
    private let cellReuseIdentifier = "SketchCell"
    var numberOfCellsToLoad = 0
    var oldestDate = ""
    var newestDate = ""
    var imageArray: NSMutableArray = []
    var dateArray: NSMutableArray = []
    var heartArray: NSMutableArray = []
    var webLinkArray: NSMutableArray = []
    var index: NSMutableArray = []
    var downloadAllowed = false
    
    
    override func viewDidLoad() {
        sketchGetHandler.getSketches(3, fromDate: "", toDate: oldestDate, callback: addSketches)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollHandler.secondSketchViewed(scrollView) && downloadAllowed {
            downloadAllowed = false
            sketchGetHandler.getSketches(3, fromDate: "", toDate: oldestDate, callback: addSketches)
        }
        if scrollHandler.pulledDownFromTopOfScreen(scrollView) {
            sketchGetHandler.getSketches(10, fromDate: newestDate, toDate: "", callback: newestSketchChecker)
        }

    }
    
    func newestSketchChecker (sketches: NSMutableArray, errorOccured: Bool) {
        if sketches == [] {
            println("Well that's the newest sketches!")
        }
        else {
            var imageArrayHolder = sketchGetHandler.parseImagesFromSketchArray(sketches)
            var dateArrayHolder = sketchGetHandler.parseDatesFromSketchArray(sketches)
            var heartArrayHolder = sketchGetHandler.parseHeartsFromSketchArray(sketches)
            var webLinkArrayHolder = sketchGetHandler.parseImageLinksFromSketchArray(sketches)

            if sketches.count > 6 {
                imageArray = []
                dateArray = []
                heartArray = []
                webLinkArray = []
            }
 
            for image in imageArrayHolder {
                imageArray.insertObject(image, atIndex: 0)
            }
            
            for date in dateArrayHolder {
                dateArray.insertObject(date, atIndex: 0)
            }
            
            for heart in heartArrayHolder {
                heartArray.insertObject(heart, atIndex: 0)
            }
            
            for webLink in webLinkArrayHolder {
                webLinkArray.insertObject(webLink, atIndex: 0)
            }
            
            numberOfCellsToLoad = sketches.count
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.collectionView!.reloadData()
            })
            
        }
    }

    
    func addSketches (sketches: NSMutableArray, errorOccured: Bool) {
        
        if errorOccured == true {
            print("Oops looks like something went wrong")
        }
        else {
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
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCellsToLoad
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let sketchCell = collectionView.dequeueReusableCellWithReuseIdentifier("sketchCell", forIndexPath: indexPath) as! SketchCell

        println("\(indexPath.item)")
        sketchCell.sketchView.image = UIImage(data: imageArray[indexPath.item] as! NSData)
        sketchCell.dateCreatedLabel.text = "Created \(dateArray[indexPath.item])"
        sketchCell.heartLabel.text = "Hearts: \(heartArray[indexPath.item])"
        sketchCell.webLink = webLinkArray[indexPath.item] as! NSURL
        index.addObject(indexPath)
        
        return sketchCell
    }
    
    @IBAction func homeButton(sender: AnyObject) {
        scrollHandler.scrollToTopOfScreen(self.collectionView!, indexArray: index)
    }

}
