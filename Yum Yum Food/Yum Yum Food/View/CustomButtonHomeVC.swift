//
//  CustomButtonHomeVC.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 10.12.2024.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColors.backgroundCell
        setTitle("See all", for: .normal)
        setTitleColor(AppColors.main, for: .normal)
        titleLabel?.font = .Rubick.regular.size(of: 14)
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
