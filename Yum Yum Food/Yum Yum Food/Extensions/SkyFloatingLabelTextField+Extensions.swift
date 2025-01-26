//
//  File.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 26.11.2024.
//

import UIKit
import SkyFloatingLabelTextField

extension SkyFloatingLabelTextField {
    
    func configureBorderTextField(placeholder: String, tintColor: UIColor, textColor: UIColor, borderColor: UIColor, selectedBorderColor: UIColor, isSecure: Bool = false, cornerRadius: CGFloat = 5.0) {
        self.placeholder = placeholder
        self.tintColor = tintColor
        self.textColor = textColor
        self.lineColor = borderColor
        self.selectedTitleColor = selectedBorderColor
        self.selectedLineColor = selectedBorderColor
        self.isSecureTextEntry = isSecure

        self.borderStyle = .none
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
        self.autocapitalizationType = .none

        self.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        
        self.setTitleVisible(false)
        self.titleLabel.isHidden = true
        self.textAlignment = .left
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 10)
        return bounds.inset(by: padding)
    }

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    // MARK: - Settings eye icon in password
    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.rightViewRect(forBounds: bounds)
        return CGRect(x: originalRect.origin.x - 10, // Сдвиг влево
                      y: originalRect.origin.y,
                      width: originalRect.size.width,
                      height: originalRect.size.height)
    }
    
    @objc private func textFieldDidBeginEditing() {
        self.layer.borderColor = self.selectedLineColor.cgColor
    }
    
    @objc private func textFieldDidEndEditing() {
        self.layer.borderColor = self.lineColor.cgColor
    }
}
