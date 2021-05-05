//
//  GradientLayer.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import UIKit

class GradientLayer: CAGradientLayer {

    override func layoutSublayers() {
        super.layoutSublayers()
        
        frame = super.bounds
    }
}
