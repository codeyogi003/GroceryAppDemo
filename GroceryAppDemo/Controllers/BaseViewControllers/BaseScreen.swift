//
//  BaseScreen.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 10/12/23.
//

import UIKit

class BaseScreen: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(named: ColorsEnum.BackgroundGrey.rawValue)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationController?.topViewController!.navigationItem.leftBarButtonItem = backBarButtonItem
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
