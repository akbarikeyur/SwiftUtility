//
//  MyUIViewController+Additions.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import UIKit

private var kMyLayoutGuideConstraint = "kMyLayoutGuideConstraint"

@objc public extension UIViewController {

    /**
     This method is provided to override by viewController's if the library lifts a viewController which you doesn't want to lift . This may happen if you have implemented side menu feature in your app and the library try to lift the side menu controller. Overriding this method in side menu class to return correct controller should fix the problem.
    */
    func parentMyContainerViewController() -> UIViewController? {
        return self
    }
    
    /**
    To set customized distance from keyboard for textField/textView. Can't be less than zero
     
     @deprecated    Due to change in core-logic of handling distance between textField and keyboard distance, this layout contraint tweak is no longer needed and things will just work out of the box regardless of constraint pinned with safeArea/layoutGuide/superview
    */
    @available(*, deprecated, message: "Due to change in core-logic of handling distance between textField and keyboard distance, this layout contraint tweak is no longer needed and things will just work out of the box regardless of constraint pinned with safeArea/layoutGuide/superview.")
    @IBOutlet @objc var MyLayoutGuideConstraint: NSLayoutConstraint? {
        get {
            
            return objc_getAssociatedObject(self, &kMyLayoutGuideConstraint) as? NSLayoutConstraint
        }

        set(newValue) {
            objc_setAssociatedObject(self, &kMyLayoutGuideConstraint, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
