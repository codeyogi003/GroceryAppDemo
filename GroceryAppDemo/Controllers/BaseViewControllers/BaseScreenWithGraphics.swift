//
//  BaseScreenViewController.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 08/12/23.
//

import UIKit

class BaseScreenWithGraphics: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ResourcesEnum.BackgroundGraphic.rawValue)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(named: ColorsEnum.LightPurple.rawValue)!.withAlphaComponent(0.95).cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.locations = [0.0, 0.6]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(backgroundImageView)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
    }
}
