//
//  FacebookButton.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 18.01.2025.
//

import Foundation
import UIKit
class FacebookButton: UIButton {
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.setTitle(" Continue with Facebook", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.setImage(UIImage(named: "Facebook"), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        
        if let originalImage = UIImage(named: "Facebook") {
            let resizedImage = originalImage.resized(to: CGSize(width: 30, height: 30))
            self.setImage(resizedImage, for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

