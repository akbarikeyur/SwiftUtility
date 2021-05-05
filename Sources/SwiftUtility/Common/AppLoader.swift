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
    
    func showLoader()
    {
        removeLoader()
        DispatchQueue.main.async { [self] in
            let window = UIApplication.shared.windows.first
            window?.isUserInteractionEnabled = false
            loader = UIActivityIndicatorView(frame: CGRect(x: ((window?.frame.size.width)!-50)/2, y: ((window?.frame.size.height)!-50)/2, width: 50, height: 50))
            loader.tintColor = BlueColor
            window?.addSubview(loader)
            loader.hidesWhenStopped = true
            loader.startAnimating()
        }
    }
    
    func removeLoader()
    {
        DispatchQueue.main.async { [self] in
            UIApplication.shared.windows.first?.isUserInteractionEnabled = true
            if loader == nil {
                return
            }
            loader.stopAnimating()
            loader = nil
            loader.removeFromSuperview()
        }
    }
}
