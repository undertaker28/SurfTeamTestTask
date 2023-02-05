//
//  CustomModalViewController.swift
//  SurfTeamTestTask
//
//  Created by Pavel on 2.02.23.
//

import UIKit
import SnapKit

class CustomModalViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "TitleColor")
        label.text = "Стажировка в Surf"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var firstDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "Gray")
        label.text = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackViewOfTitleAndFirstDescriptionLabels: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, firstDescriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var carouselView = СarouselView()
    
    private lazy var secondDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "Gray")
        label.text = "Получай стипендию, выстраивай удобный график, работай на современном железе."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tagsView: TagsView = {
        let tagsView = TagsView()
        tagsView.numOfRows = 2
        tagsView.tags = Directions.directions
        return tagsView
    }()
    
    private lazy var stackViewOfSecondDescriptionLabelAndTagsView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [secondDescriptionLabel, tagsView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "Gray")
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
    
    private lazy var stackViewOfQuestionLabelAndSendRequestButton: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [questionLabel, sendRequestButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(stackViewOfTitleAndFirstDescriptionLabels)
        view.addSubview(carouselView)
        view.addSubview(stackViewOfSecondDescriptionLabelAndTagsView)
        view.addSubview(stackViewOfQuestionLabelAndSendRequestButton)
    }
    
    private func makeConstraints() {
        stackViewOfTitleAndFirstDescriptionLabels.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        carouselView.snp.makeConstraints {
            $0.top.equalTo(stackViewOfTitleAndFirstDescriptionLabels.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        stackViewOfSecondDescriptionLabelAndTagsView.snp.makeConstraints {
            $0.top.equalTo(carouselView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        stackViewOfQuestionLabelAndSendRequestButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-58)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    @objc private func sendRequest() {
        let successAlert = UIAlertController(title: "Поздравляем!", message: "Ваша заявка успешно отправлена!", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
        present(successAlert, animated: true)
    }
}
