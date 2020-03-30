//
//  Collection+Extension.swift
//  OTPView
//
//  Created by Majumdar, Amit on 30/03/20.
//  Copyright © 2020 Stride[247]. All rights reserved.
//

import Foundation

extension Collection {
    /// Returns the element at given index
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
