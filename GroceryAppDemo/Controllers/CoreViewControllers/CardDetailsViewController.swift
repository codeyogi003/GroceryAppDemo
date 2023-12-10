//
//  CardDetailsViewController.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 10/12/23.
//

import UIKit
import StripePaymentsUI

class CardDetailsViewController: BaseScreen {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.CardPageTitleLabel.fetchLocalizedString()
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .left
        return label
    }()
    
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: ResourcesEnum.CardGraphic.rawValue)
        return imageView
    }()

    private let useCardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: ColorsEnum.GoAheadGreen.rawValue)
        button.setTitle(ResourcesEnum.CardPageUseCardButtonLabel.fetchLocalizedString(), for: .normal)
        button.setTitleColor(UIColor(named: ColorsEnum.TextColorSecondary.rawValue), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.layer.cornerRadius = UtilityClass.buttonCornerRadius
        return button
    }()
    
    private let scanButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: ResourcesEnum.ScanIcon.rawValue), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.layer.cornerRadius = UtilityClass.buttonCornerRadius
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: ColorsEnum.BackgroundGrey.rawValue)
        self.tabBarController!.tabBar.isHidden = true
        useCardButton.addTarget(self, action: #selector(useCardButtonAction(_:)), for: .touchUpInside)
        self.navigationController?.navigationBar.isHidden = false
        view.addSubview(titleLabel)
        view.addSubview(cardImageView)
        view.addSubview(useCardButton)
        view.addSubview(scanButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ]
        
        let useCardButtonConstraints = [
            useCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            useCardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            useCardButton.heightAnchor.constraint(equalToConstant: 50),
            useCardButton.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        let cardImageViewConstraints = [
            cardImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            cardImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardImageView.heightAnchor.constraint(equalToConstant: view.bounds.height*0.2)
        ]
        
        let scanButtonConstraints = [
            scanButton.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 40),
            scanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanButton.heightAnchor.constraint(equalToConstant: 30),
            scanButton.widthAnchor.constraint(equalToConstant: 30)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(useCardButtonConstraints)
        NSLayoutConstraint.activate(cardImageViewConstraints)
        NSLayoutConstraint.activate(scanButtonConstraints)
        
    }
    
    @objc func useCardButtonAction(_ sender: UIButton) {
        let confirmationVC = ConfirmationViewController()
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(confirmationVC, animated: true)
        }
    }
    
}
