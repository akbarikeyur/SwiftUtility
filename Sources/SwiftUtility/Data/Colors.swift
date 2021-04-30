//
//  Colors.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit

var ClearColor = UIColor.clear
var WhiteColor = UIColor.white
var DarkTextColor = colorFromHex(hex: "1F1C1C")
var LightTextColor = colorFromHex(hex: "808080")
var BlueColor = colorFromHex(hex: "006BB5")
var BlackColor = UIColor.black
var DarkBorderColor = colorFromHex(hex: "707070")
var LightBorderColor = colorFromHex(hex: "EDEDED")
var RedColor = colorFromHex(hex: "D11313")
var GreenColor = colorFromHex(hex: "00A869")

enum ColorType : Int32 {
    case Clear = 0
    case White = 1
    case DarkText = 2
    case LightText = 3
    case Blue = 4
    case Black = 5
    case DarkBorder = 6
    case LightBorder = 7
    case Red = 8
    case Green = 9
}

extension ColorType {
    var value: UIColor {
        get {
            switch self {
                case .Clear:
                    return ClearColor
                case .White:
                    return WhiteColor
                case .Black:
                    return BlackColor
                case .DarkText:
                    return DarkTextColor
                case .LightText:
                    return LightTextColor
                case .Blue:
                    return BlueColor
                case .DarkBorder:
                    return DarkBorderColor
                case .LightBorder:
                    return LightBorderColor
                case .Red:
                    return RedColor
                case .Green:
                    return GreenColor
            }
        }
    }
}

enum GradientColorType : Int32 {
    case Clear = 0
    case Login = 1
}

extension GradientColorType {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .Login: //1
                gradient.colors = [
                    colorFromHex(hex: "FD7F5E").cgColor,
                    colorFromHex(hex: "FF625F").cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 0)
            }
            
            return gradient
        }
    }
}


enum GradientColorTypeForView : Int32 {
    case Clear = 0
    case App = 1
}


extension GradientColorTypeForView {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .App: //1
                gradient.colors = [
                    colorFromHex(hex: "FD7F5E").cgColor,
                    colorFromHex(hex: "FF625F").cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 0)
            }
            
            return gradient
        }
    }
}

