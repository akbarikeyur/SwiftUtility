//
//  Fonts.swift
//  Cozy Up
//
//  Created by Keyur on 22/05/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import Foundation
import UIKit

let APP_REGULAR = "Poppins-Regular"
let APP_BOLD = "Poppins-Bold"
let APP_ITALIC = "Poppins-Italic"
let APP_MEDIUM = "Poppins-Medium"
let APP_LIGHT = "Poppins-Light"

enum FontType : String {
    case Clear = ""
    case ARegular = "ar"
    case ABold = "ab"
    case AItalic = "ai"
    case AMedium = "am"
    case ALight = "al"
}

extension FontType {
    var value: String {
        get {
            switch self {
                case .Clear:
                    return APP_REGULAR
                case .ARegular:
                    return APP_REGULAR
                case .ABold:
                    return APP_BOLD
                case .AItalic:
                    return APP_ITALIC
                case .AMedium:
                    return APP_MEDIUM
                case .ALight:
                    return APP_LIGHT
            }
        }
    }
}
