//
//  MyInvocation.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import UIKit

@objc public class MyInvocation: NSObject {
    @objc public weak var target: AnyObject?
    @objc public var action: Selector
    
    @objc public init(_ target: AnyObject, _ action: Selector) {
        self.target = target
        self.action = action
    }
    
    @objc public func invoke(from: Any) {
        if let target = target {
            UIApplication.shared.sendAction(action, to: target, from: from, for: UIEvent())
        }
    }

    deinit {
        target = nil
    }
}
