//
//  TagsView.swift
//  SurfTeamTestTask
//
//  Created by Pavel on 5.02.23.
//

import UIKit

class TagsView: UIView {
    var tagViews = [TagView]()
    
    var tags = [String]() {
        didSet {
            tagViews = []
            var totalWidth: CGFloat = 0
            // Create individual tag views and get the total width
            tags.forEach { directionText in
                let tagView = TagView()
                tagView.directionLabel.text = directionText
                let width = 53 + tagView.directionLabel.text.orEmpty.count * 6
                totalWidth += CGFloat(width)
                tagViews.append(tagView)
            }
            
            let rowWidth: CGFloat = totalWidth / CGFloat(numOfRows)
            var indexTag = 0
            while indexTag < tagViews.count {
                // Create a new row horizontal StackView
                let horizontalStackView = UIStackView()
                horizontalStackView.spacing = 12
                verticalStackView.addArrangedSubview(horizontalStackView)
                var currentWidthRow: CGFloat = 0
                // Add tag views
                while currentWidthRow < rowWidth, indexTag < tagViews.count {
                    let tagView = tagViews[indexTag]
                    let width = 53 + tagView.directionLabel.text.orEmpty.count * 6
                    horizontalStackView.addArrangedSubview(tagView)
                    currentWidthRow += CGFloat(width)
                    indexTag += 1
                }
            }
        }
    }

    var numOfRows = 2
    
    // Vertical StackView to hold the rows
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(verticalStackView)
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview()
            $0.height.equalTo(verticalStackView.snp.height).offset(0)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalTo(scrollView.contentLayoutGuide)
        }
    }
}
