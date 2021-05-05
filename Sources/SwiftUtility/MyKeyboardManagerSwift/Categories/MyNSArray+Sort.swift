//
//  MyNSArray+Sort.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import Foundation
import UIKit

/**
UIView.subviews sorting category.
*/
internal extension Array where Element: UIView {
    
    ///--------------
    /// MARK: Sorting
    ///--------------
    
    /**
    Returns the array by sorting the UIView's by their tag property.
    */
    func sortedArrayByTag() -> [Element] {
        
        return sorted(by: { (obj1: Element, obj2: Element) -> Bool in
            
            return (obj1.tag < obj2.tag)
        })
    }
    
    /**
    Returns the array by sorting the UIView's by their tag property.
    */
    func sortedArrayByPosition() -> [Element] {
        
        return sorted(by: { (obj1: Element, obj2: Element) -> Bool in
            if obj1.frame.minY != obj2.frame.minY {
                return obj1.frame.minY < obj2.frame.minY
            } else {
                return obj1.frame.minX < obj2.frame.minX
            }
        })
    }
}
