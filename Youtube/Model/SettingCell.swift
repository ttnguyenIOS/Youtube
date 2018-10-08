import UIKit

class SettingCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            iconImage.tintColor = isHighlighted ? .red : .darkGray
            nameLabel.textColor = isHighlighted ? .red : .black
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.image {
                iconImage.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImage.tintColor = .darkGray
            }
        }
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "settings")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    func setupView() {
        addSubview(nameLabel)
        addSubview(iconImage)
        
        addConstraintsWithForMat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImage, nameLabel)
        addConstraintsWithForMat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithForMat(format: "V:[v0(30)]", views: iconImage)
    
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
