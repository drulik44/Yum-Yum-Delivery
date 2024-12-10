//
//  FavoriteViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import SnapKit

class FavoriteViewController: UIViewController {
    weak var coordinator: FavoriteCoordinator?
    
    
    let segmentedControl: CustomSegmentedControl = {
        let items = ["Food", "Restaurants"]
        let sc = CustomSegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        
        sc.translatesAutoresizingMaskIntoConstraints = false
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: AppColors.textColorMain,
            .font: UIFont.Rubick.bold.size(of: 17)
        ]
        sc.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        // Настройка шрифта и цвета текста для обычного состояния
        let normalTextAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: AppColors.textColorMain,
            .font: UIFont.Rubick.regular.size(of: 16)
        ]
        sc.setTitleTextAttributes(normalTextAttributes, for: .normal)
        
        
        return sc
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = AppColors.background
        view.addSubview(segmentedControl)
        
        

    }
    

    //MARK: - Setup constrainst
    
    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
    }
    
    
}
