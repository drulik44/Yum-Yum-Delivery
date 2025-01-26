//
//  DeliveryAddressView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 25.01.2025.
//


import UIKit
import MapKit
import SnapKit
import SkyFloatingLabelTextField

class DeliveryAddressView: UIView {
    let mapView = MKMapView()
    let addressLabel = UILabel()
    let addressTextField = SkyFloatingLabelTextField()
    let searchButton = UIButton()
    let saveButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = AppColors.background

        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        addSubview(mapView)

        addressLabel.text = "Address".localized()
        addressLabel.font = .Rubick.bold.size(of: 18)
        addSubview(addressLabel)

        addressTextField.configureBorderTextField(
            placeholder: "   Enter your address".localized(),
            tintColor: AppColors.backgroundCell,
            textColor: AppColors.textColorMain,
            borderColor: AppColors.gray,
            selectedBorderColor: AppColors.main,
            cornerRadius: 15.0
        )
        addSubview(addressTextField)

        searchButton.setImage(UIImage(named: "Search"), for: .normal)
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.layer.cornerRadius = 20
        if let originalImage = UIImage(named: "Search") {
            let resizedImage = originalImage.resized(to: CGSize(width: 30, height: 30))
            searchButton.setImage(resizedImage, for: .normal)
        }
        addSubview(searchButton)

        saveButton.setTitle("Save".localized(), for: .normal)
        saveButton.titleLabel?.font = .Rubick.bold.size(of: 20)
        saveButton.setTitleColor(AppColors.backgroundCell, for: .normal)
        saveButton.backgroundColor = AppColors.main
        saveButton.layer.cornerRadius = 25
        addSubview(saveButton)
    }

    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(550)
        }

        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }

        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(40)
        }

        searchButton.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.top)
            make.left.equalTo(addressTextField.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(addressTextField.snp.height)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}