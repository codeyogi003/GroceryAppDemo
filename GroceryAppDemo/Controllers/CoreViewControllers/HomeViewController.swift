//
//  ViewController.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 07/12/23.
//

import UIKit

class HomeViewController: BaseScreenWithGraphics {

    private var screenWidth: CGFloat = 0.0
    private var screenHeight: CGFloat = 0.0
    
    private let titleImageBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: ResourcesEnum.PackageIcon.rawValue)
        return imageView
    }()
    
    private let bottomSectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: ColorsEnum.BackgroundGrey.rawValue)
        return view
    }()
    
    private let bottomSectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.HomePageTitleLabel.fetchLocalizedString()
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let bottomSectionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.HomePageDesciptionLabel.fetchLocalizedString()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = UIColor(named: ColorsEnum.TextColorDescription.rawValue)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let orderButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: ColorsEnum.GoAheadGreen.rawValue)
        button.setTitle(ResourcesEnum.OrderNowButtonLabel.fetchLocalizedString(), for: .normal)
        button.setTitleColor(UIColor(named: ColorsEnum.TextColorSecondary.rawValue), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.layer.cornerRadius = UtilityClass.buttonCornerRadius
        return button
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: ColorsEnum.BackgroundWhite.rawValue)
        button.setTitle(ResourcesEnum.DismissButtonLabel.fetchLocalizedString(), for: .normal)
        button.setTitleColor(UIColor(named: ColorsEnum.TextColorPrimary.rawValue), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.layer.cornerRadius = UtilityClass.buttonCornerRadius
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = view.bounds.width
        screenHeight = view.bounds.height
        orderButton.addTarget(self, action: #selector(orderButtonAction(_:)), for: .touchUpInside)
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: ColorsEnum.BackgroundGrey.rawValue)
        bottomSectionView.layer.cornerRadius = 50
        bottomSectionView.layer.masksToBounds = true
        titleImageBackgroundView.layer.cornerRadius = (screenWidth*0.2)*0.5
        
        view.addSubview(bottomSectionView)
        bottomSectionView.addSubview(titleImageBackgroundView)
        titleImageBackgroundView.addSubview(titleImageView)
        bottomSectionView.addSubview(bottomSectionTitleLabel)
        bottomSectionView.addSubview(bottomSectionDescriptionLabel)
        bottomSectionView.addSubview(orderButton)
        bottomSectionView.addSubview(dismissButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let bottomSectionViewConstraints = [
            bottomSectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSectionView.heightAnchor.constraint(equalToConstant: screenHeight*0.6)
        ]
        
        let titleImageBackgroundViewConstraints = [
            titleImageBackgroundView.centerXAnchor.constraint(equalTo: bottomSectionView.centerXAnchor),
            titleImageBackgroundView.heightAnchor.constraint(equalToConstant: screenWidth*0.2),
            titleImageBackgroundView.widthAnchor.constraint(equalToConstant: screenWidth*0.2),
            titleImageBackgroundView.topAnchor.constraint(equalTo: bottomSectionView.topAnchor, constant: 50)
        ]
        
        let titleImageViewConstraints = [
            titleImageView.centerXAnchor.constraint(equalTo: titleImageBackgroundView.centerXAnchor),
            titleImageView.centerYAnchor.constraint(equalTo: titleImageBackgroundView.centerYAnchor)
        ]
        
        let titleLabelConstraints = [
            bottomSectionTitleLabel.topAnchor.constraint(equalTo: titleImageBackgroundView.bottomAnchor, constant: 50),
            bottomSectionTitleLabel.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 20),
            bottomSectionTitleLabel.trailingAnchor.constraint(equalTo: bottomSectionView.trailingAnchor, constant: -20)
        ]
        
        let descriptionLabelConstraints = [
            bottomSectionDescriptionLabel.topAnchor.constraint(equalTo: bottomSectionTitleLabel.bottomAnchor, constant: 40),
            bottomSectionDescriptionLabel.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 20),
            bottomSectionDescriptionLabel.trailingAnchor.constraint(equalTo: bottomSectionView.trailingAnchor, constant: -20)
        ]
        
        let orderButtonConstraints = [
            orderButton.topAnchor.constraint(equalTo: bottomSectionDescriptionLabel.bottomAnchor, constant: 30),
            orderButton.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 30),
            orderButton.trailingAnchor.constraint(equalTo: bottomSectionView.trailingAnchor, constant: -30),
            orderButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let dismissButtonConstraints = [
            dismissButton.topAnchor.constraint(equalTo: orderButton.bottomAnchor, constant: 20),
            dismissButton.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 30),
            dismissButton.trailingAnchor.constraint(equalTo: bottomSectionView.trailingAnchor, constant: -30),
            dismissButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(titleImageBackgroundViewConstraints)
        NSLayoutConstraint.activate(titleImageViewConstraints)
        NSLayoutConstraint.activate(bottomSectionViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
        NSLayoutConstraint.activate(orderButtonConstraints)
        NSLayoutConstraint.activate(dismissButtonConstraints)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeFromParent()
    }
    
    @objc private func orderButtonAction(_ sender: UIButton) {
        let homeTabBarVC = HomeTabBarViewController()
        homeTabBarVC.modalPresentationStyle = .fullScreen
        self.present(homeTabBarVC, animated: true)
    }
    
    @objc private func dismissButtonAction(_ sender: UIButton) {
        // No action specified
    }

}
