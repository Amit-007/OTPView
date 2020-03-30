//
//  String+Extension.swift
//  OTPView
//
//  Created by Majumdar, Amit on 30/03/20.
//  Copyright © 2020 Stride[247]. All rights reserved.
//

import Foundation

extension String {
    /// Checks if the string contains only numeric data or not
    func isNumeric() -> Bool {
        return rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
