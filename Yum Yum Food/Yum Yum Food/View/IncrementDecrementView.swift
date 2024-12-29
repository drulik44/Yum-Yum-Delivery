//
//  IncrementDecrementView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 19.12.2024.
//

import UIKit
import SnapKit

class IncrementDecrementView: UIView {
    
    var quantity: Int = 1 {
        didSet {
            valueLabel.text = "\(quantity)"
            onQuantityChange?(quantity) // Уведомление об изменении количества
        }
    }
    
    var onQuantityChange: ((Int) -> Void)?

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        self.backgroundColor = AppColors.backgroundCell
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        setupActions()
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
    
    private func setupActions() {
        incrementButton.addTarget(self, action: #selector(incrementValue), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrementValue), for: .touchUpInside)
    }
    
    @objc private func incrementValue() {
        quantity += 1
    }
    
    @objc private func decrementValue() {
        if quantity > 1 {
            quantity -= 1
        }
    }
}
