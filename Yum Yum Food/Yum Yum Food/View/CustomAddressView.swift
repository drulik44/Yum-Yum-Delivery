//
//  CustomAddressView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 07.12.2024.
//

import Foundation
import UIKit
import SnapKit

class CustomAddressView: UIView {

     let leftIconImageView = UIImageView()
     let addressLabel = UILabel()
     let rightIconImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func setupUI() {
        leftIconImageView.image = UIImage(named : "home address") 
        leftIconImageView.contentMode = .scaleAspectFit
        addSubview(leftIconImageView)

        addressLabel.font = .systemFont(ofSize: 16)
         
         addressLabel.textColor = AppColors.textColorMain
         addressLabel.text = "Select your address".localized()
         addressLabel.font = .Rubick.regular.size(of:16)
        addSubview(addressLabel)

        rightIconImageView.image = UIImage(named: "Icon")
        rightIconImageView.contentMode = .scaleAspectFit
        addSubview(rightIconImageView)
    }

     func setupConstraints() {
        leftIconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        rightIconImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(leftIconImageView.snp.right).offset(10)
            make.right.equalTo(rightIconImageView.snp.left).offset(-10)
            make.centerY.equalToSuperview()
        }
    }
}
