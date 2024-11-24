//
//  ViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        
        let label: UILabel = {
            let label = UILabel()
            label.text = "Hello, World!"
            label.font = .Rubick.boldItalic.size(of: 30)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = AppColors.textColorMain
            return label
        }()
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        
    }


}
