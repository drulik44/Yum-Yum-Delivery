//
//  FooterView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 30.12.2024.
//

import UIKit
import SnapKit

class FooterView: UICollectionReusableView {

    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.main
        label.font = .Rubick.bold.size(of: 16)
        label.textAlignment = .right
        label.text = " 0₴"
        return label
    }()
    
    let TotalPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 20)
        label.textAlignment = .left
        label.text = "Total".localized()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(TotalPriceTitleLabel) // Добавляем заголовок

        addSubview(totalPriceLabel)
        
        TotalPriceTitleLabel.snp.makeConstraints { make in
                   make.top.equalToSuperview().offset(10) // Уменьшаем отступ сверху
                   make.left.equalToSuperview().offset(20)
                   make.bottom.equalToSuperview().offset(-10)
               }

               totalPriceLabel.snp.makeConstraints { make in
                   make.top.equalToSuperview().offset(10) // Уменьшаем отступ сверху
                   make.right.equalToSuperview().offset(-20)
                   make.bottom.equalToSuperview().offset(-10)
                   make.leading.equalTo(TotalPriceTitleLabel.snp.trailing).offset(10) // Размещаем справа от заголовка
               }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

