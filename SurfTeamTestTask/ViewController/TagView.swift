//
//  TagView.swift
//  SurfTeamTestTask
//
//  Created by Pavel on 5.02.23.
//

import UIKit

class TagView: UIView {
    lazy var directionLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "Black")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var selected: Bool = false {
        didSet {
            if selected {
                backgroundColor = UIColor(named: "Black")
                directionLabel.textColor = .white
            } else {
                backgroundColor = UIColor(named: "LightGray")
                directionLabel.textColor = UIColor(named: "Black")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "LightGray")
        addSubview(directionLabel)
        makeConstraints()
        layer.cornerRadius = 12
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(gotTap(_:)))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        directionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview().offset(-14)
        }
    }

    @objc func gotTap(_ sender: Any?) {
        selected.toggle()
    }
}
