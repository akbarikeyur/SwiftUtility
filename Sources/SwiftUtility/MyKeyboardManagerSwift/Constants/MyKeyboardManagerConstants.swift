//
//  MyKeyboardManagerConstants.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import Foundation

///-----------------------------------
/// MARK: MyAutoToolbarManageBehaviour
///-----------------------------------

/**
`MyAutoToolbarBySubviews`
Creates Toolbar according to subview's hirarchy of Textfield's in view.

`MyAutoToolbarByTag`
Creates Toolbar according to tag property of TextField's.

`MyAutoToolbarByPosition`
Creates Toolbar according to the y,x position of textField in it's superview coordinate.
*/
@objc public enum MyAutoToolbarManageBehaviour: Int {
    case bySubviews
    case byTag
    case byPosition
}

/**
 `MyPreviousNextDisplayModeDefault`
 Show NextPrevious when there are more than 1 textField otherwise hide.
 
 `MyPreviousNextDisplayModeAlwaysHide`
 Do not show NextPrevious buttons in any case.
 
 `MyPreviousNextDisplayModeAlwaysShow`
 Always show nextPrevious buttons, if there are more than 1 textField then both buttons will be visible but will be shown as disabled.
 */
@objc public enum MyPreviousNextDisplayMode: Int {
    case `default`
    case alwaysHide
    case alwaysShow
}

/**
 `MyEnableModeDefault`
 Pick default settings.
 
 `MyEnableModeEnabled`
 setting is enabled.
 
 `MyEnableModeDisabled`
 setting is disabled.
 */
@objc public enum MyEnableMode: Int {
    case `default`
    case enabled
    case disabled
}

/*
 /---------------------------------------------------------------------------------------------------\
 \---------------------------------------------------------------------------------------------------/
 |                                   iOS Notification Mechanism                                    |
 /---------------------------------------------------------------------------------------------------\
 \---------------------------------------------------------------------------------------------------/
 
 ------------------------------------------------------------
 When UITextField become first responder
 ------------------------------------------------------------
 - UITextFieldTextDidBeginEditingNotification (UITextField)
 - UIKeyboardWillShowNotification
 - UIKeyboardDidShowNotification
 
 ------------------------------------------------------------
 When UITextView become first responder
 ------------------------------------------------------------
 - UIKeyboardWillShowNotification
 - UITextViewTextDidBeginEditingNotification (UITextView)
 - UIKeyboardDidShowNotification
 
 ------------------------------------------------------------
 When switching focus from UITextField to another UITextField
 ------------------------------------------------------------
 - UITextFieldTextDidEndEditingNotification (UITextField1)
 - UITextFieldTextDidBeginEditingNotification (UITextField2)
 - UIKeyboardWillShowNotification
 - UIKeyboardDidShowNotification
 
 ------------------------------------------------------------
 When switching focus from UITextView to another UITextView
 ------------------------------------------------------------
 - UITextViewTextDidEndEditingNotification: (UITextView1)
 - UIKeyboardWillShowNotification
 - UITextViewTextDidBeginEditingNotification: (UITextView2)
 - UIKeyboardDidShowNotification
 
 ------------------------------------------------------------
 When switching focus from UITextField to UITextView
 ------------------------------------------------------------
 - UITextFieldTextDidEndEditingNotification (UITextField)
 - UIKeyboardWillShowNotification
 - UITextViewTextDidBeginEditingNotification (UITextView)
 - UIKeyboardDidShowNotification
 
 ------------------------------------------------------------
 When switching focus from UITextView to UITextField
 ------------------------------------------------------------
 - UITextViewTextDidEndEditingNotification (UITextView)
 - UITextFieldTextDidBeginEditingNotification (UITextField)
 - UIKeyboardWillShowNotification
 - UIKeyboardDidShowNotification
 
 ------------------------------------------------------------
 When opening/closing UIKeyboard Predictive bar
 ------------------------------------------------------------
 - UIKeyboardWillShowNotification
 - UIKeyboardDidShowNotification
 
 ------------------------------------------------------------
 On orientation change
 ------------------------------------------------------------
 - UIApplicationWillChangeStatusBarOrientationNotification
 - UIKeyboardWillHideNotification
 - UIKeyboardDidHideNotification
 - UIApplicationDidChangeStatusBarOrientationNotification
 - UIKeyboardWillShowNotification
 - UIKeyboardDidShowNotification
 - UIKeyboardWillShowNotification
 - UIKeyboardDidShowNotification
 
 */
