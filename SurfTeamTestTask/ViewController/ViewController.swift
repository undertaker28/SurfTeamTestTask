//
//  ViewController.swift
//  SurfTeamTestTask
//
//  Created by Pavel on 2.02.23.
//

import UIKit

class ViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Background.png")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        makeConstraints()
        configureSheet()
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureSheet() {
        let customModalViewController = UINavigationController(rootViewController: CustomModalViewController())
        
        customModalViewController.isModalInPresentation = true
        if let sheet = customModalViewController.sheetPresentationController {
            sheet.preferredCornerRadius = 32
            sheet.detents = [.custom(resolver: { context in
                0.61 * context.maximumDetentValue
            }), .large()]
            sheet.largestUndimmedDetentIdentifier = .large
        }
        navigationController?.present(customModalViewController, animated: true)
    }
}
