//
//  MyUIScrollView+Additions.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import Foundation
import UIKit

private var kMyShouldIgnoreScrollingAdjustment      = "kMyShouldIgnoreScrollingAdjustment"
private var kMyShouldIgnoreContentInsetAdjustment   = "kMyShouldIgnoreContentInsetAdjustment"
private var kMyShouldRestoreScrollViewContentOffset = "kMyShouldRestoreScrollViewContentOffset"

@objc public extension UIScrollView {
    
    /**
     If YES, then scrollview will ignore scrolling (simply not scroll it) for adjusting textfield position. Default is NO.
     */
    @objc var shouldIgnoreScrollingAdjustment: Bool {
        get {
            
            if let aValue = objc_getAssociatedObject(self, &kMyShouldIgnoreScrollingAdjustment) as? Bool {
                return aValue
            } else {
                return false
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kMyShouldIgnoreScrollingAdjustment, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /**
     If YES, then scrollview will ignore content inset adjustment (simply not updating it) when keyboard is shown. Default is NO.
     */
    @objc var shouldIgnoreContentInsetAdjustment: Bool {
        get {
            
            if let aValue = objc_getAssociatedObject(self, &kMyShouldIgnoreContentInsetAdjustment) as? Bool {
                return aValue
            } else {
                return false
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kMyShouldIgnoreContentInsetAdjustment, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     To set customized distance from keyboard for textField/textView. Can't be less than zero
     */
    @objc var shouldRestoreScrollViewContentOffset: Bool {
        get {
            
            if let aValue = objc_getAssociatedObject(self, &kMyShouldRestoreScrollViewContentOffset) as? Bool {
                return aValue
            } else {
                return false
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kMyShouldRestoreScrollViewContentOffset, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

internal extension UITableView {
    
    func previousIndexPath(of indexPath: IndexPath) -> IndexPath? {
        var previousRow = indexPath.row - 1
        var previousSection = indexPath.section
        
        //Fixing indexPath
        if previousRow < 0 {
            previousSection -= 1
            
            if previousSection >= 0 {
                previousRow = self.numberOfRows(inSection: previousSection) - 1
            }
        }
        
        if previousRow >= 0 && previousSection >= 0 {
            return IndexPath(row: previousRow, section: previousSection)
        } else {
            return nil
        }
    }
}

internal extension UICollectionView {
    
    func previousIndexPath(of indexPath: IndexPath) -> IndexPath? {
        var previousRow = indexPath.row - 1
        var previousSection = indexPath.section
        
        //Fixing indexPath
        if previousRow < 0 {
            previousSection -= 1
            
            if previousSection >= 0 {
                previousRow = self.numberOfItems(inSection: previousSection) - 1
            }
        }
        
        if previousRow >= 0 && previousSection >= 0 {
            return IndexPath(item: previousRow, section: previousSection)
        } else {
            return nil
        }
    }
}
