//
//  OTPInputField.swift
//  OTPView
//
//  Created by Majumdar, Amit on 30/03/20.
//  Copyright © 2020 Stride[247]. All rights reserved.
//

import UIKit

/// This class represents OTP Input Fields
open class OTPInputField: UITextField {
    override open func deleteBackward() {
        super.deleteBackward()
        _ = delegate?.textField?(self, shouldChangeCharactersIn: NSRange(location: .zero, length: .zero), replacementString: "")
    }
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
