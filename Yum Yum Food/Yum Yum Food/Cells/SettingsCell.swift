//
//  SettingsCell.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 08.12.2024.
//

import UIKit

class SettingsCell: UITableViewCell {
    static let reuseableId: String = "Settings Option"

    let label: UILabel = {
        let lb = UILabel()
        lb.textColor = AppColors.textColorMain
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .Rubick.regular.size(of: 16)
        return lb
    }()

    let icon: UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let arrow: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = AppColors.gray
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let border: UIView = {
        let v = UIView()
        v.backgroundColor = AppColors.background
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SettingsCell.reuseableId)
        setupViews()
        setupConstraints()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [label, icon, border, arrow].forEach {
            contentView.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24),

            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: arrow.leadingAnchor, constant: -10),

            arrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            arrow.widthAnchor.constraint(equalToConstant: 15),
            arrow.heightAnchor.constraint(equalToConstant: 15),

            border.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func setup(for item: SectionOptionSettings) {
        label.text = item.name
        icon.image = UIImage(named: item.icon)?.withRenderingMode(.alwaysOriginal)
    }
}
