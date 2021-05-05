//
//  MyTextView.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import UIKit

/** @abstract UITextView with placeholder support   */
open class MyTextView: UITextView {
    
    @objc required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        #if swift(>=4.2)
        let UITextViewTextDidChange = UITextView.textDidChangeNotification
        #else
        let UITextViewTextDidChange = Notification.Name.UITextViewTextDidChange
        #endif

        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshPlaceholder), name: UITextViewTextDidChange, object: self)
    }
    
    @objc override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        #if swift(>=4.2)
        let notificationName = UITextView.textDidChangeNotification
        #else
        let notificationName = Notification.Name.UITextViewTextDidChange
        #endif

        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshPlaceholder), name: notificationName, object: self)
    }
    
    @objc override open func awakeFromNib() {
        super.awakeFromNib()
        
        #if swift(>=4.2)
        let UITextViewTextDidChange = UITextView.textDidChangeNotification
        #else
        let UITextViewTextDidChange = Notification.Name.UITextViewTextDidChange
        #endif

        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshPlaceholder), name: UITextViewTextDidChange, object: self)
    }
    
    deinit {
        My_PlaceholderLabel.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }

    private var placeholderInsets: UIEdgeInsets {
        return UIEdgeInsets(top: self.textContainerInset.top, left: self.textContainerInset.left + self.textContainer.lineFragmentPadding, bottom: self.textContainerInset.bottom, right: self.textContainerInset.right + self.textContainer.lineFragmentPadding)
    }
    
    private var placeholderExpectedFrame: CGRect {
        let placeholderInsets = self.placeholderInsets
        let maxWidth = self.frame.width-placeholderInsets.left-placeholderInsets.right
        let expectedSize = My_PlaceholderLabel.sizeThatFits(CGSize(width: maxWidth, height: self.frame.height-placeholderInsets.top-placeholderInsets.bottom))
        
        return CGRect(x: placeholderInsets.left, y: placeholderInsets.top, width: maxWidth, height: expectedSize.height)
    }

    lazy var My_PlaceholderLabel: UILabel = {
        let label = UILabel()
        
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = self.font
        label.textAlignment = self.textAlignment
        label.backgroundColor = UIColor.clear
        #if swift(>=5.1)
        label.textColor = UIColor.systemGray
        #else
        label.textColor = UIColor.lightText
        #endif
        label.alpha = 0
        self.addSubview(label)
        
        return label
    }()
    
    /** @abstract To set textView's placeholder text color. */
    @IBInspectable open var placeholderTextColor: UIColor? {
        
        get {
            return My_PlaceholderLabel.textColor
        }
        
        set {
            My_PlaceholderLabel.textColor = newValue
        }
    }
    
    /** @abstract To set textView's placeholder text. Default is nil.    */
    @IBInspectable open var placeholder: String? {
        
        get {
            return My_PlaceholderLabel.text
        }
        
        set {
            My_PlaceholderLabel.text = newValue
            refreshPlaceholder()
        }
    }

    /** @abstract To set textView's placeholder attributed text. Default is nil.    */
    open var attributedPlaceholder: NSAttributedString? {
        get {
            return My_PlaceholderLabel.attributedText
        }

        set {
            My_PlaceholderLabel.attributedText = newValue
            refreshPlaceholder()
        }
    }
    
    @objc override open func layoutSubviews() {
        super.layoutSubviews()
        
        My_PlaceholderLabel.frame = placeholderExpectedFrame
    }
    
    @objc internal func refreshPlaceholder() {
        
        if !text.isEmpty || !attributedText.string.isEmpty {
            My_PlaceholderLabel.alpha = 0
        } else {
            My_PlaceholderLabel.alpha = 1
        }
    }
    
    @objc override open var text: String! {
        
        didSet {
            refreshPlaceholder()
        }
    }
    
    open override var attributedText: NSAttributedString! {
        
        didSet {
            refreshPlaceholder()
        }
    }
    
    @objc override open var font: UIFont? {
        
        didSet {
            
            if let unwrappedFont = font {
                My_PlaceholderLabel.font = unwrappedFont
            } else {
                My_PlaceholderLabel.font = UIFont.systemFont(ofSize: 12)
            }
        }
    }
    
    @objc override open var textAlignment: NSTextAlignment {
        didSet {
            My_PlaceholderLabel.textAlignment = textAlignment
        }
    }
    
    @objc override open var delegate: UITextViewDelegate? {
        
        get {
            refreshPlaceholder()
            return super.delegate
        }
        
        set {
            super.delegate = newValue
        }
    }
    
    @objc override open var intrinsicContentSize: CGSize {
        guard !hasText else {
            return super.intrinsicContentSize
        }
        
        var newSize = super.intrinsicContentSize
        let placeholderInsets = self.placeholderInsets
        newSize.height = placeholderExpectedFrame.height + placeholderInsets.top + placeholderInsets.bottom
        
        return newSize
    }
}

//#if swift(>=5.1)
//import SwiftUI
//
//struct MyTextViewSwiftUI: UIViewRepresentable {
//    func makeUIView(context: Context) -> MyTextView {
//        MyTextView(frame: .zero)
//    }
//
//    func updateUIView(_ view: MyTextView, context: Context) {
//    }
//}
//
//struct MyTextViewSwiftUI_Preview: PreviewProvider {
//    static var previews: some View {
//        MyTextViewSwiftUI()
//    }
//}
//
//#endif
//
