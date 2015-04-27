//
//  ScrollHandler.swift
//  Peinto
//
//  Created by Nick Jones on 22/04/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import Foundation
import UIKit

class ScrollHandler {
    
    func secondSketchViewed (viewToCheck: UIScrollView) -> Bool {
        if viewToCheck.contentOffset.y > viewToCheck.contentSize.height - (viewToCheck.frame.size.height * 3) {
            return true
        }
        return false
    }
    
    func pulledDownFromTopOfScreen (viewToCheck: UIScrollView) -> Bool {
        if (viewToCheck.contentOffset.y < -10){
            return true
        }
        return false
    }
    
    func swipedToBottomOfScreen (viewToCheck: UIScrollView) -> Bool {
        if viewToCheck.contentOffset.y > (viewToCheck.contentSize.height - viewToCheck.frame.size.height) {
            return true
        }
        return false
    }
    
    func scrollToTopOfScreen (viewToSCroll: UICollectionView, indexArray: NSMutableArray) {
        viewToSCroll.scrollToItemAtIndexPath(indexArray[0] as! NSIndexPath, atScrollPosition: UICollectionViewScrollPosition.Top, animated: true)
    }
}