//
//  UIView+Extension.swift
//  OTPView
//
//  Created by Majumdar, Amit on 30/03/20.
//  Copyright © 2020 Stride[247]. All rights reserved.
//

import UIKit

public extension UIView {
    
    func fillSuperView() {
        if let superview = superview {
            translatesAutoresizingMaskIntoConstraints = false
            [topAnchor.constraint(equalTo: superview.topAnchor),
             leadingAnchor.constraint(equalTo: superview.leadingAnchor),
             trailingAnchor.constraint(equalTo: superview.trailingAnchor),
             bottomAnchor.constraint(equalTo: superview.bottomAnchor)].forEach { $0.isActive = true }
        }
    }
}
