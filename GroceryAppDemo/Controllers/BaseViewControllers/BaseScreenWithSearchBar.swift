//
//  BaseScreenWithSearchBar.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import UIKit

class BaseScreenWithSearchBar: UIViewController {

    internal let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .left
        return label
    }()
    
    internal let backButton: UIButton = {
        let backButton = UIButton(frame: .init(x: 0.0, y: 0.0, width: 30, height: 30))
        let backImage = UIImage(named: ResourcesEnum.ArrowBackward.rawValue)
        DispatchQueue.main.async {
            backButton.setImage(backImage, for: .normal)
        }
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.backgroundColor = .clear
        return backButton
    }()
    
    internal let customSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = ResourcesEnum.SearchBarPlaceholderLabel.fetchLocalizedString()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = UIColor(named: ColorsEnum.BackgroundWhite.rawValue)
        searchBar.searchTextField.backgroundColor = UIColor(named: ColorsEnum.BackgroundWhite.rawValue)
        searchBar.tintColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        searchBar.searchTextField.tintColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        searchBar.layer.cornerRadius = UtilityClass.searchBarCornerRadius
        searchBar.clipsToBounds = true
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(named: ColorsEnum.BackgroundGrey.rawValue)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationController?.topViewController!.navigationItem.leftBarButtonItem = backBarButtonItem
        view.addSubview(titleLabel)
        view.addSubview(customSearchBar)
        applyConstraints()
        
    }
    
    private func applyConstraints() {
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ]
        
        let searchBarConstraints = [
            customSearchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            customSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customSearchBar.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(searchBarConstraints)
        
    }
    
    @objc private func backButtonAction(_ sender: UIButton) {
        if let navigationController = self.navigationController {
            if navigationController.viewControllers.first == self {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first {
                    let homeVC = HomeViewController()
                    window.rootViewController = homeVC
                    window.makeKeyAndVisible()
                }
            } else {
                navigationController.popViewController(animated: true)
            }
        }
    }
}
