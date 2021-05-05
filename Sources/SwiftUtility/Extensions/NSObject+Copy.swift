//
//  CopyingValues.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import UIKit

public extension NSObject {
    func copyValues(fromObject : AnyObject?) {
        
        if fromObject == nil {
            return
        }
        
        let mirrored_object = Mirror(reflecting: fromObject!)
        for (_, attr) in mirrored_object.children.enumerated() {
            if let property_name = attr.label as String? {
                
                self.setValue(fromObject!.value(forKey: property_name), forKey: property_name)
            }
        }
    }
}
