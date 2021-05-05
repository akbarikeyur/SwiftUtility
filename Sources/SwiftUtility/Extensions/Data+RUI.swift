//
//  Data+RUI.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import UIKit

public extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            printData("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
