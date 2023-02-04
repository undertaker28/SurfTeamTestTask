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
        view.addSubview(stackViewOfTitleAndDescriptionLabels)
        view.addSubview(stackViewOfQuestionLabelAndSendRequestButton)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        makeConstraints()
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
}

extension CustomModalViewController: UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return directions.count
    }
}

extension CustomModalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        guard let cell = cell as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.directionLabel.text = directions[indexPath.row]
        
        return cell
    }
}

extension CustomModalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 53 + directions[indexPath.row].count * 6
        return CGSize(width: width, height: 44)
    }
}
