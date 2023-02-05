//
//  CustomModalViewController.swift
//  SurfTeamTestTask
//
//  Created by Pavel on 2.02.23.
//

import UIKit
import SnapKit

class CustomModalViewController: UIViewController {
    let directions = Directions.directions

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "TitleColor")
        label.text = "Стажировка в Surf"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "DescriptionColor")
        label.text = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "DescriptionColor")
        label.text = "Хочешь к нам?"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var sendRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить заявку", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "Black")
        button.layer.cornerRadius = 30
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 44, bottom: 20, right: 44)
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        button.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        button.addPressAnimation()
        return button
    }()
    
    @objc private func sendRequest() {
        let successAlert = UIAlertController(title: "Поздравляем!", message: "Ваша заявка успешно отправлена!", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
        present(successAlert, animated: true)
    }
    
    private lazy var stackViewOfTitleAndDescriptionLabels: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var stackViewOfQuestionLabelAndSendRequestButton: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [questionLabel, sendRequestButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.alignment = .center
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupCollectionView()
        makeConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(stackViewOfTitleAndDescriptionLabels)
        view.addSubview(stackViewOfQuestionLabelAndSendRequestButton)
        view.addSubview(collectionView)
    }
    
    private func makeConstraints() {
        stackViewOfTitleAndDescriptionLabels.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(stackViewOfTitleAndDescriptionLabels.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        stackViewOfQuestionLabelAndSendRequestButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-58)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension CustomModalViewController: UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return directions.count * 2
    }
}

extension CustomModalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath)
        guard let cell = cell as? CollectionViewCell else {
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
            offset.x += width / 2
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

extension CustomModalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 53 + directions[indexPath.row % directions.count].count * 6
        return CGSize(width: width, height: 44)
    }
}
