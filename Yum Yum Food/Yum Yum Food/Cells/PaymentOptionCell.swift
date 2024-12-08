import UIKit

class PaymentOptionCell: UITableViewCell {
    static let reuseableId: String = "PaymentOption"

    let label: UILabel = {
        let lb = UILabel()
        lb.textColor = AppColors.textColorMain
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .Rubick.regular.size(of: 14)
        return lb
    }()

    let icon: UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFit  // Используем .scaleAspectFit для настройки размера иконки
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
        iv.isHidden = true
        iv.alpha = 0
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let circleImage: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "circle")
        iv.tintColor = AppColors.gray.withAlphaComponent(0.4)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let border: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray2.withAlphaComponent(0.2)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: PaymentOptionCell.reuseableId)
        setupViews()
        setupConstraints()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [label, icon, border, arrow, circleImage].forEach {
            contentView.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            icon.widthAnchor.constraint(equalToConstant: 30),
            icon.heightAnchor.constraint(equalToConstant: 30),

            label.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            arrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            arrow.heightAnchor.constraint(equalToConstant: 20),

            circleImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            circleImage.heightAnchor.constraint(equalToConstant: 25),
            circleImage.widthAnchor.constraint(equalToConstant: 25),

            border.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func setup(for item: SectionOption) {
        label.text = item.name
        icon.image = UIImage(named: item.icon)?.withRenderingMode(.alwaysOriginal)
        circleImage.image = UIImage(systemName: item.selected ? "record.circle.fill" : "circle")
        circleImage.tintColor = item.selected ? AppColors.main : AppColors.gray.withAlphaComponent(0.4)
    }
}

