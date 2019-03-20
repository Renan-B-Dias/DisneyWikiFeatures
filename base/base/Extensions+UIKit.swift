//
//  Extensions+UIKit.swift
//  base
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import Foundation

public extension UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
}

public extension UIViewController {
    
    static var nibName: String {
        return String(describing: self)
    }
}
