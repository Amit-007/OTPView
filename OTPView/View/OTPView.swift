//
//  OTPView.swift
//  OTPView
//
//  Created by Majumdar, Amit on 30/03/20.
//  Copyright © 2020 Stride[247]. All rights reserved.
//

import UIKit

@IBDesignable
public class OTPView: UIView {
    /// Specifies whether the values should be masked or not
    @IBInspectable
    public var isSecuredTextEntry: Bool = false {
        didSet {
            updateView()
        }
    }
    
    /// Specifies the number of digits
    @IBInspectable
    public var numberOfDigits: Int = 6 {
        didSet {
            updateView()
        }
    }
    
    /// Text Color of the texts
    @IBInspectable
    public var textColor: UIColor = .black {
        didSet {
            updateView()
        }
    }
    
    /// Text Color of the texts
    @IBInspectable
    public var placeHolder: UIColor = .lightGray {
        didSet {
            updateView()
        }
    }
    
    /// Font of the texts
    public var font: UIFont = .boldSystemFont(ofSize: 12) {
        didSet {
            updateView()
        }
    }
    
    /// Border Color of the textFields
    @IBInspectable
    public var borderColor: UIColor = .lightGray {
        didSet {
            updateView()
        }
    }
    
    /// Background Color of the textFields
    @IBInspectable
    public var textFieldbackgroundColor: UIColor = .clear {
        didSet {
            updateView()
        }
    }
    
    /// Cusror Tint Color of the textFields
    @IBInspectable
    public var cursorTintColor: UIColor = .blue {
        didSet {
            updateView()
        }
    }
    
    /// Border Width of the textFields
    @IBInspectable
    public var borderWidth: CGFloat = 1.0 {
        didSet {
            updateView()
        }
    }
    
    /// Corner Radius of the textFields
    @IBInspectable
    public var cornerRadius: CGFloat = 4.0 {
        didSet {
            updateView()
        }
    }
    
    /// InterItem Spacing
    @IBInspectable
    public var spacing: CGFloat = 2.0 {
        didSet {
            updateView()
        }
    }
    
    /// Placeholder
    @IBInspectable
    public var placeholder: String? = nil {
        didSet {
            updateView()
        }
    }
    
    /// keyboardType
    public var keyboardType: UIKeyboardType = .numberPad {
        didSet {
            updateView()
        }
    }
    
    /// keyboardType
    public var textAlignment: NSTextAlignment = .center {
        didSet {
            updateView()
        }
    }
    
    /// keyboardType
    public var textContentType: UITextContentType = .oneTimeCode {
        didSet {
            updateView()
        }
    }
    
    /// An array that will hold UITextField
    private var textFields = [UITextField()]
    
    /// `OTPProtocol` instance
    weak var delegate: OTPProtocol?
    
    /// This array will hold all the digits entered in the fields
    private var enteredCode = [String]()
    
    /// Max Length
    private let maxLength = 1
    
    /// Empty Code
    private let emptyCode = ""
    
    /// Minimum Number of Digits
    private let noDigits: Int = .zero
    
    /// Initializer
    ///
    /// - Parameter frame: CGRect
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// Required Initializer
    ///
    /// - Parameter aDecoder: NSCoder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func updateView() {
        if numberOfDigits > noDigits {
            textFields.removeAll()
            enteredCode.removeAll()
            subviews.forEach { $0.removeFromSuperview() }
            for index in 1...numberOfDigits {
                let textField = getOTPInputField(index: index)
                textFields.append(textField)
                enteredCode.append(emptyCode)
            }
            arrangeSubviews(subviews: textFields)
        } else {
            assertionFailure("numberOfDigits can never be a negative number or zero")
        }
    }
    
    /// This method will arrange suviews
    ///
    /// - Parameter subviews: An array of UITextField
    private func arrangeSubviews(subviews: [UITextField]) {
        let stack = UIStackView(arrangedSubviews: subviews)
        stack.axis = .horizontal
        stack.spacing = spacing
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.fillSuperView()
    }
    
    /// This method will Append the individual digits & form the final the verification code & fire the delegate
    private func appendAndNotify() {
        let verificationCode = enteredCode.joined()
        if verificationCode.count == numberOfDigits {
            delegate?.verificationCode(self, didFinishedEnteringCode: verificationCode)
        }
    }
    
    /// This method will make the first text iput box as first responder
    func makeFirstResponder() {
        DispatchQueue.main.async {
            if let textField = self.textFields.first {
                textField.becomeFirstResponder()
            }
        }
    }
    
    /// This method will clear all the textFields
    func clearAll() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let `self` = self else {
                return
            }
            self.textFields.forEach { $0.text = self.emptyCode }
            }, completion: { (_) in
        })
    }
    
    /// Clears the textfields data & remove from array containing verification code
    func clearTextInVerificationCodeView() {
        textFields.compactMap { $0.text = emptyCode }
        enteredCode.removeAll()
    }
}


extension OTPView {
    
    /// This method will return an instance of a 'OTPInputField'
    ///
    /// - Parameter index: index that will be used to set tag
    /// - Returns: UITextField instance
    func getOTPInputField(index: Int) -> OTPInputField {
        let textField = OTPInputField()
        textField.tag = index
        textField.isSecureTextEntry = isSecuredTextEntry
        textField.textColor = textColor
        textField.font = font
        textField.textAlignment = textAlignment
        textField.keyboardType = keyboardType
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = borderWidth
        textField.layer.cornerRadius = cornerRadius
        textField.placeholder = placeholder
        textField.tintColor = cursorTintColor
        textField.attributedPlaceholder = NSAttributedString(string: placeholder ?? emptyCode, attributes: [NSAttributedString.Key.foregroundColor: placeHolder])
        textField.backgroundColor = textFieldbackgroundColor
        textField.textContentType = textContentType
        textField.delegate = self
        return textField
    }
}


extension OTPView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count > 1, string.count == textFields.count, string.isNumeric() {
            enteredCode.removeAll()
            for index in 0..<string.count {
                let character = String(string[string.index(string.startIndex, offsetBy: index)])
                enteredCode.append(character)
                textFields[index].text = character
            }
            delegate?.verificationCode(self, didFinishEnteringCode: string)
            textField.resignFirstResponder()
            return false
        }
        if let textFieldText = textField.text {
            
            // Get the latest text everytime
            if string.count == maxLength {
                
                // Update TextField Text
                textField.text = string
                
                // An array is maintained that will hold the individual codes entered in the field
                // Check if element exist in the index of the array if yes, replace the contents of the array & insert the latest one or else simply insert the value
                if enteredCode[safe: textField.tag - 1] != nil {
                    enteredCode[textField.tag - 1] = emptyCode
                }
                    enteredCode.insert(string, at: textField.tag - 1)
                // Each time a text is entered move to the next field
                if let nextTextField = viewWithTag(textField.tag + 1) as? UITextField {
                    nextTextField.becomeFirstResponder()
                    if nextTextField.text?.isEmpty ?? true {
                        nextTextField.text = emptyCode
                    } else {
                        nextTextField.resignFirstResponder()
                        appendAndNotify()
                    }
                } else {
                    // Resign if its the last field
                    textField.resignFirstResponder()
                    appendAndNotify()
                }
            } else {
                
                // Move to the previous field only if the field is empty
                if textFieldText.isEmpty {
                    if let previousTextField = viewWithTag(textField.tag - 1) as? UITextField {
                        previousTextField.becomeFirstResponder()
                    } else {
                        textField.resignFirstResponder()
                    }
                } else {
                    
                    // If Delete was pressed make sure to remove the element from the array
                    if string == emptyCode {
                        enteredCode[textField.tag - 1] = emptyCode
                    }
                    textField.text = string
                }
            }
            return string.count <= maxLength
        } else {
            return true
        }
    }
}
