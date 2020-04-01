//
//  OTPProtocol.swift
//  OTPView
//
//  Created by Majumdar, Amit on 30/03/20.
//  Copyright © 2020 Stride[247]. All rights reserved.
//

import UIKit

/// Implement this delegate to notify when the user completes entering the code
public protocol OTPProtocol: class {
    
    /// This delegate method will notify when the user completes entering code
    ///
    /// - Parameters:
    ///   - view: 'VerificationCodeView' instance
    ///   - code: the entered code
    func verificationCode(_ view: OTPView, didFinishedEnteringCode code: String)
}
