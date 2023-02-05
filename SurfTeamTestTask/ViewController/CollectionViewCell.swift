//
//  CollectionViewCell.swift
//  SurfTeamTestTask
//
//  Created by Pavel on 3.02.23.
//

import UIKit

class СarouselViewCell: UICollectionViewCell {
    static var identifier: String {
        String(describing: self)
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                directionLabel.textColor = .white
                directionLabel.backgroundColor = UIColor(named: "Black")
            } else {
                directionLabel.textColor = UIColor(named: "Black")
                directionLabel.backgroundColor = UIColor(named: "LightGray")
            }
        }
    }

    lazy var directionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "LightGray")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        label.textAlignment = .center
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "Black")
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(directionLabel)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        directionLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
    }
}
