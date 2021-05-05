//
//  MyUITextFieldView+Additions.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import Foundation
import UIKit

/**
Uses default keyboard distance for textField.
*/
public let kMyUseDefaultKeyboardDistance = CGFloat.greatestFiniteMagnitude

private var kMyKeyboardDistanceFromTextField = "kMyKeyboardDistanceFromTextField"
private var kMyKeyboardEnableMode = "kMyKeyboardEnableMode"
private var kMyShouldResignOnTouchOutsideMode = "kMyShouldResignOnTouchOutsideMode"
private var kMyIgnoreSwitchingByNextPrevious = "kMyIgnoreSwitchingByNextPrevious"

/**
UIView category for managing UITextField/UITextView
*/
@objc public extension UIView {

    /**
     To set customized distance from keyboard for textField/textView. Can't be less than zero
     */
    @objc var keyboardDistanceFromTextField: CGFloat {
        get {
            
            if let aValue = objc_getAssociatedObject(self, &kMyKeyboardDistanceFromTextField) as? CGFloat {
                return aValue
            } else {
                return kMyUseDefaultKeyboardDistance
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kMyKeyboardDistanceFromTextField, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     If shouldIgnoreSwitchingByNextPrevious is true then library will ignore this textField/textView while moving to other textField/textView using keyboard toolbar next previous buttons. Default is false
     */
    @objc var ignoreSwitchingByNextPrevious: Bool {
        get {
            
            if let aValue = objc_getAssociatedObject(self, &kMyIgnoreSwitchingByNextPrevious) as? Bool {
                return aValue
            } else {
                return false
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kMyIgnoreSwitchingByNextPrevious, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
//    /**
//     Override Enable/disable managing distance between keyboard and textField behaviour for this particular textField.
//     */
    @objc var enableMode: MyEnableMode {
        get {
            
            if let savedMode = objc_getAssociatedObject(self, &kMyKeyboardEnableMode) as? MyEnableMode {
                return savedMode
            } else {
                return .default
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kMyKeyboardEnableMode, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     Override resigns Keyboard on touching outside of UITextField/View behaviour for this particular textField.
     */
    @objc var shouldResignOnTouchOutsideMode: MyEnableMode {
        get {
            
            if let savedMode = objc_getAssociatedObject(self, &kMyShouldResignOnTouchOutsideMode) as? MyEnableMode {
                return savedMode
            } else {
                return .default
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kMyShouldResignOnTouchOutsideMode, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
