//
//  CollectionViewCell.swift
//  SurfTeamTestTask
//
//  Created by Pavel on 3.02.23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "TitleColor")
        label.text = "Стажировка в Surf"
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 6
        print(titleLabel.text)
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
