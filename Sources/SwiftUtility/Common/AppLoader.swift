//
//  File.swift
//  
//
//  Created by Keyur on 05/05/21.
//

import Foundation
import UIKit
open class AppLoader : NSObject {
    
    public static let shared = AppLoader()
    
    var loader : UIActivityIndicatorView!
}

public func showLoader()
{
    removeLoader()
    DispatchQueue.main.async {
        let window = UIApplication.shared.windows.first
        window?.isUserInteractionEnabled = false
        AppLoader.shared.loader = UIActivityIndicatorView(frame: CGRect(x: ((window?.frame.size.width)!-50)/2, y: ((window?.frame.size.height)!-50)/2, width: 50, height: 50))
        AppLoader.shared.loader.tintColor = BlueColor
        window?.addSubview(loader)
        AppLoader.shared.loader.hidesWhenStopped = true
        AppLoader.shared.loader.startAnimating()
    }
}

public func removeLoader()
{
    DispatchQueue.main.async {
        UIApplication.shared.windows.first?.isUserInteractionEnabled = true
        if AppLoader.shared.loader == nil {
            return
        }
        AppLoader.shared.loader.stopAnimating()
        AppLoader.shared.loader.removeFromSuperview()
        AppLoader.shared.loader = nil
    }
}
