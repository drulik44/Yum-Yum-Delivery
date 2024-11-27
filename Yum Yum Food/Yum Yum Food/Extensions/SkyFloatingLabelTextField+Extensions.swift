//
//  File.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 26.11.2024.
//

import UIKit
import SkyFloatingLabelTextField

extension SkyFloatingLabelTextField {
    
    func configureBorderTextField(placeholder: String,  tintColor: UIColor, textColor: UIColor, borderColor: UIColor, selectedBorderColor: UIColor, isSecure: Bool = false, cornerRadius: CGFloat = 5.0) {
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

        self.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    @objc private func textFieldDidBeginEditing() {
        self.layer.borderColor = self.selectedLineColor.cgColor
    }
    
    @objc private func textFieldDidEndEditing() {
        self.layer.borderColor = self.lineColor.cgColor
    }
}


