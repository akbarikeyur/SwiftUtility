//
//  NSErrorAdditions.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import UIKit

public extension NSError {
    
    func isNoConnectionError() -> Bool {
        return self.domain == NSURLErrorDomain && self.code == NSURLErrorNotConnectedToInternet
    }
    
    func isFileNotFoundError() -> Bool {
        return self.domain == NSCocoaErrorDomain && self.code == NSFileReadNoSuchFileError
    }
    
}
