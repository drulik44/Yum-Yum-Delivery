//
//  IncrementDecrementView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 19.12.2024.
//

import UIKit
import SnapKit

class IncrementDecrementView: UIView {
    
    private let decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.setTitleColor(AppColors.main, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        return button
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .Rubick.regular.size(of: 18)
        label.textColor = AppColors.main
        label.textAlignment = .center
        return label
    }()
    
    private let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(AppColors.main, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        return button
    }()
    
    private var value: Int = 1 {
        didSet {
            valueLabel.text = "\(value)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
        // Устанавливаем цвет фона для UIView
        self.backgroundColor = AppColors.backgroundCell // Здесь можно задать любой цвет
        self.layer.cornerRadius = 25 // Закругленные углы (опционально)
        self.layer.masksToBounds = true // Обрезка содержимого за пределами углов (опционально)
        incrementButton.addTarget(self, action: #selector(incrementValue), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrementValue), for: .touchUpInside)


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(decrementButton)
        addSubview(valueLabel)
        addSubview(incrementButton)
    }
    
    private func setupConstraints() {
        decrementButton.snp.makeConstraints { make in
            make.right.equalTo(valueLabel.snp.left).offset(-5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
        }
        
        incrementButton.snp.makeConstraints { make in
            make.left.equalTo(valueLabel.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
    @objc private func incrementValue() {
        value += 1
    }
    
    @objc private func decrementValue() {
        if value > 0 {
            value -= 1
        }
    }
}
