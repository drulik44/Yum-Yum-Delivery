//
//  GoogleButton.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 18.01.2025.
//
import UIKit
class GoogleButton: UIButton {
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.setTitle("  Continue with Google", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.setImage(UIImage(named: "Gicon"), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        
        if let originalImage = UIImage(named: "Gicon") {
            let resizedImage = originalImage.resized(to: CGSize(width: 26, height: 26))
            self.setImage(resizedImage, for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
