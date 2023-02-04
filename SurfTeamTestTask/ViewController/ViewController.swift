//
//  ViewController.swift
//  SurfTeamTestTask
//
//  Created by Pavel on 2.02.23.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        configureSheet()
    }
    
    func assignbackground() {
        let background = UIImage(named: "Background.png")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFit
        //imageView.clipsToBounds = true
        imageView.image = background
        //imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    private func configureSheet() {
        let vc = CustomModalViewController()
        let navVC = UINavigationController(rootViewController: vc)
        
        navVC.isModalInPresentation = true
        if let sheet = navVC.sheetPresentationController {
            sheet.preferredCornerRadius = 32
            sheet.detents = [.custom(resolver: { context in
                0.42 * context.maximumDetentValue
            }), .large()]
            sheet.largestUndimmedDetentIdentifier = .large
        }
        navigationController?.present(navVC, animated: true)
    }
}
