//
//  СarouselView.swift
//  SurfTeamTestTask
//
//  Created by Pavel on 5.02.23.
//

import UIKit

class СarouselView: UICollectionView {
    let directions = Directions.directions

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        super.init(frame: .zero, collectionViewLayout: layout)
        showsHorizontalScrollIndicator = false
        allowsMultipleSelection = true
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(СarouselViewCell.self, forCellWithReuseIdentifier: СarouselViewCell.identifier)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension СarouselView: UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return directions.count * 2
    }
}

extension СarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: СarouselViewCell.identifier, for: indexPath)
        guard let cell = cell as? СarouselViewCell else {
            return UICollectionViewCell()
        }

        var index = indexPath.item
        if index > directions.count - 1 {
            index -= directions.count
        }
        cell.directionLabel.text = directions[index % directions.count]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var offset = collectionView.contentOffset
        let width = collectionView.contentSize.width
        if offset.x < width / 4 {
            // MARK: - Make an explanation of why + 6
            offset.x += width / 2 + 6
            collectionView.setContentOffset(offset, animated: false)
        } else if offset.x > width / 4 * 3 {
            offset.x -= width / 2
            collectionView.setContentOffset(offset, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.left, animated: true)
    }
}

extension СarouselView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // MARK: - Make an explanation of why 53 and 6
        let width = 53 + directions[indexPath.row % directions.count].count * 6
        return CGSize(width: width, height: 44)
    }
}
