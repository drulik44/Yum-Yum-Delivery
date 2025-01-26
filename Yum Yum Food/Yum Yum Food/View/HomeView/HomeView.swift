
import UIKit
import SnapKit

class HomeView: UIView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let customAddressView = CustomAddressView()
    
    let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner 1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let fastestDeliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Fastest delivery 🔥".localized()
        label.font = .Rubick.bold.size(of: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 2, height: 4)
        label.layer.shadowRadius = 4
        return label
    }()
    
    let fastestDeliveryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(FastestDeliveryCell.self, forCellWithReuseIdentifier: FastestDeliveryCell.reusableId)
        return collectionView
    }()
    
    let popularItemsLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular items 🥳".localized()
        label.font = .Rubick.bold.size(of: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 2, height: 4)
        label.layer.shadowRadius = 4
        return label
    }()
    
    let popularItemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(PopularItemsCell.self, forCellWithReuseIdentifier: PopularItemsCell.reusableId)
        return collectionView
    }()
    
    let seeAllButton = CustomButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(customAddressView)
        contentView.addSubview(bannerImageView)
        contentView.addSubview(fastestDeliveryLabel)
        contentView.addSubview(seeAllButton)
        contentView.addSubview(fastestDeliveryCollectionView)
        contentView.addSubview(popularItemsLabel)
        contentView.addSubview(popularItemsCollectionView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        customAddressView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(-15)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.top.equalTo(customAddressView.snp.bottom).offset(10)
            make.height.equalTo(190)
            make.width.equalTo(350)
            make.centerX.equalToSuperview()
        }
        
        fastestDeliveryLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(fastestDeliveryLabel)
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(80)
        }
        
        fastestDeliveryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(fastestDeliveryLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(210)
        }
        
        popularItemsLabel.snp.makeConstraints { make in
            make.top.equalTo(fastestDeliveryCollectionView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        popularItemsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(popularItemsLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(210)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
