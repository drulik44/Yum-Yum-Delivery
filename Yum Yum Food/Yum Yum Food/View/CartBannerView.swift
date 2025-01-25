//
//  CartBannerView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 27.12.2024.
//

import UIKit
import SnapKit

class CartBannerView: UIView {
    
    var onTap: (() -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Go to cart".localized()
        label.font = .Rubick.bold.size(of:16)
        label.textColor = .white
        return label
    }()

   

    private let containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        //stack.spacing = 8
        stack.alignment = .center
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = AppColors.main
        layer.cornerRadius = 20
        clipsToBounds = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bannerTapped))
                addGestureRecognizer(tapGesture)
                isUserInteractionEnabled = true
        
        containerView.addArrangedSubview(titleLabel)
        //containerView.addArrangedSubview(priceLabel)

        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

       
        
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func bannerTapped() {
              onTap?()
          }
}
