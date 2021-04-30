//
//  Utility.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit
import AVFoundation
import SafariServices

let CURRENCY = "$"

struct PLATFORM {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

//MARK:- Image Function
func compressImage(_ image: UIImage, to toSize: CGSize) -> UIImage {
    var actualHeight: Float = Float(image.size.height)
    var actualWidth: Float = Float(image.size.width)
    let maxHeight: Float = Float(toSize.height)
    //600.0;
    let maxWidth: Float = Float(toSize.width)
    //800.0;
    var imgRatio: Float = actualWidth / actualHeight
    let maxRatio: Float = maxWidth / maxHeight
    //50 percent compression
    if actualHeight > maxHeight || actualWidth > maxWidth {
        if imgRatio < maxRatio {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight
            actualWidth = imgRatio * actualWidth
            actualHeight = maxHeight
        }
        else if imgRatio > maxRatio {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = maxWidth
        }
        else {
            actualHeight = maxHeight
            actualWidth = maxWidth
        }
    }
    let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(actualWidth), height: CGFloat(actualHeight))
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    let imageData1: Data? = img?.jpegData(compressionQuality: 1.0)//UIImageJPEGRepresentation(img!, CGFloat(1.0))//UIImage.jpegData(img!)
    UIGraphicsEndImageContext()
    return  imageData1 == nil ? image : UIImage(data: imageData1!)!
}

func printData(_ items: Any..., separator: String = " ", terminator: String = "\n")
{
    #if DEBUG
        items.forEach {
            Swift.print($0, separator: separator, terminator: terminator)
        }
    #endif
}

func displaySubViewtoParentView(_ parentview: UIView! , subview: UIView!)
{
    subview.translatesAutoresizingMaskIntoConstraints = false
    parentview.addSubview(subview);
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
    parentview.layoutIfNeeded()
}

func displaySubViewWithScaleOutAnim(_ view:UIView){
    view.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    view.alpha = 1
    UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1.0, options: [], animations: {() -> Void in
        view.transform = CGAffineTransform.identity
    }, completion: {(_ finished: Bool) -> Void in
    })
}

func displaySubViewWithScaleInAnim(_ view:UIView){
    UIView.animate(withDuration: 0.25, animations: {() -> Void in
        view.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        view.alpha = 0.0
    }, completion: {(_ finished: Bool) -> Void in
        view.removeFromSuperview()
    })
}

//MARK:- Delay Features
func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

//MARK:- Open Url
func openUrlInSafari(strUrl : String)
{
    if strUrl.trimmed == "" {
        return
    }
    var newStrUrl = strUrl
    if !newStrUrl.contains("http://") && !newStrUrl.contains("https://") {
        newStrUrl = "http://" + strUrl
    }
    if let url = URL(string: newStrUrl) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 11.0, *) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let vc = SFSafariViewController(url: url, configuration: config)
                UIApplication.topViewController()!.present(vc, animated: true)
            } else {
                // Fallback on earlier versions
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:]) { (isOpen) in
                        printData(isOpen)
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}

//MARK:- Call
func redirectToPhoneCall(_ strNumber : String)
{
    if strNumber == "" {
        displayToast("provider_no_phone")
        return
    }
    guard let url = URL(string: "tel://\(strNumber)") else {
        displayToast("Invalid phone number")
        return
    }
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url)
    } else {
        UIApplication.shared.openURL(url)
    }
}

//MARK:- Email
func redirectToEmail(_ email : String)
{
    if email == "" || !email.isValidEmail {
        displayToast("Invalid email address")
        return
    }
    guard let url = URL(string: "mailto:\(email)") else {
        displayToast("Invalid email address")
        return
    }
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url)
    } else {
        UIApplication.shared.openURL(url)
    }
}

//MARK:- Color function
func colorFromHex(hex : String) -> UIColor
{
    return colorWithHexString(hex, alpha: 1.0)
}

func colorFromHex(hex : String, alpha:CGFloat) -> UIColor
{
    return colorWithHexString(hex, alpha: alpha)
}

func colorWithHexString(_ stringToConvert:String, alpha:CGFloat) -> UIColor {
    
    var cString:String = stringToConvert.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

func imageFromColor(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    
    let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}

//MARK:- Attribute string
func attributedStringWithColor(_ mainString : String, _ strings: [String], color: UIColor, font: UIFont? = nil) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: mainString)
    for string in strings {
        let range = (mainString as NSString).range(of: string)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        if font != nil {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font!, range: range)
        }
    }
    return attributedString
}

func attributeStringStrikeThrough(_ mainString : String) -> NSAttributedString
{
    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: mainString)
    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
    return attributeString
}

func getAttributeStringWithColor(_ main_string : String, _ substring : [String], color : UIColor?, font : UIFont?, isUnderLine : Bool) -> NSMutableAttributedString
{
    let attribute = NSMutableAttributedString.init(string: main_string)
    
    for sub_string in substring{
        let range = (main_string as NSString).range(of: sub_string)
        if let newColor = color{
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: newColor , range: range)
        }
        if let newFont = font {
            attribute.addAttribute(NSAttributedString.Key.font, value: newFont , range: range)
        }
        
        if isUnderLine{
            attribute.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: range)
            if let newColor = color{
                attribute.addAttribute(NSAttributedString.Key.underlineColor , value: newColor, range: range)
            }
        }
    }
    
    return attribute
}

func attributedStringWithBackgroundColor(_ mainString : String, _ strings: [String], bgcolor: UIColor, font: UIFont? = nil) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: mainString)
    for string in strings {
        let range = (mainString as NSString).range(of: string)
        attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: bgcolor, range: range)
        if font != nil {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font!, range: range)
        }
    }
    return attributedString
}

//MARK:- Localization
func getTranslate(_ str : String) -> String
{
    return NSLocalizedString(str, comment: "")
}

//MARK:- Get Json from file
func getJsonFromFile(_ file : String) -> [[String : Any]]
{
    if let filePath = Bundle.main.path(forResource: file, ofType: "json"), let data = NSData(contentsOfFile: filePath) {
        do {
            if let json : [[String : Any]] = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String : Any]] {
                return json
            }
        }
        catch {
            //Handle error
        }
    }
    return [[String : Any]]()
}

func convertToDictionary(_ text: String) -> [String: Any]? {
  if let data = text.data(using: .utf8) {
    do {
      return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    } catch {
      print(error.localizedDescription)
    }
  }
  return nil
}

//MARK:- Placeholder color
func setTextFieldPlaceholderColor(_ textField : UITextField, _ color : UIColor)
{
    if textField.placeholder != "" {
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}

func setupButtonHighlightEffect(_ button : UIButton, _ normalBGColor : UIColor, _ highlightBGColor : UIColor)
{
    button.setTitleColor(highlightBGColor, for: .normal)
    button.setTitleColor(normalBGColor, for: .highlighted)
    button.setBackgroundImage(imageFromColor(color: normalBGColor), for: .normal)
    button.setBackgroundImage(imageFromColor(color: highlightBGColor), for: .highlighted)
}

func displayFlotingValue(_ value : Double) -> String
{
    var finalValue = String(format: "%.2f", Float(value))
    if finalValue.contains(".00") {
        finalValue = finalValue.replacingOccurrences(of: ".00", with: "")
    }
//    else if finalValue.contains(".0") {
//        finalValue = finalValue.replacingOccurrences(of: ".0", with: "")
//    }
    return finalValue
}

func displayFlotingStar(_ price : Double) -> String
{
    var finalValue = String(format: "%.1f", Float(price))
    if finalValue.contains(".0") {
        finalValue = finalValue.replacingOccurrences(of: ".0", with: "")
    }
    return finalValue
}

func displayPriceWithCurrency(_ price : Double) -> String {
    return CURRENCY + displayFlotingValue(price)
}

func displayDiscountPriceWithCurrency(_ price : Double, _ discount : Double) -> String {
    return displayPriceWithCurrency(price - discount)
}

func getDiscountPrice(_ price : Float, _ discount : Int) -> Float {
    let newPrice = price - (price * Float(discount) / 100)
    return newPrice
}

//MARK:- Card
func showCardNumberFormattedStr(_ str:String, isRedacted:Bool = true) -> String{
    
    let tempStr:String = sendDetailByRemovingChar(sendDetailByRemovingChar(str, char:"-"), char: " ")
    var retStr:String = ""
    for i in 0..<tempStr.count{
        if(i == 4 || i == 8 || i == 12){
            retStr += "-"
        }
        retStr += tempStr[i]
    }
    if(isRedacted){
        var arr:[String] = retStr.components(separatedBy: "-")
        for i in 0..<arr.count{
            if(i == 1 || i == 2){
                arr[i] = "xxxx"
            }
        }
        retStr = arr.joined(separator: "-")
    }
    return retStr
}

func showCardExpDateFormattedStr(_ str:String) -> String{
    
    let tempStr:String = sendDetailByRemovingChar(str, char:"/")
    var retStr:String = ""
    for i in 0..<tempStr.count{
        if(i == 2){
            retStr += "/"
        }
        retStr += tempStr[i]
    }
    return retStr
}

func sendDetailByRemovingChar(_ str:String, char:String = " ") -> String{
    let regExp :String = char + "\n\t\r"
    return String(str.filter { !(regExp.contains($0))})
}

func generateCoponCode(_ length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            printData(error.localizedDescription)
        }
    }
    return nil
}

//MARK:- Toast
func displayToast(_ message:String)
{
    UIApplication.topViewController()?.view.makeToast(getTranslate(message))
}


extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
