//
//  HomeTabBarViewController.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor(named: ColorsEnum.TextColorDescription.rawValue)
        tabBar.isUserInteractionEnabled = false
        
        let viewController1 = UINavigationController(rootViewController: CategoryViewController())
        let viewController2 = UINavigationController(rootViewController: CheckoutViewController())
        let viewController3 = UINavigationController(rootViewController: UserProfileViewController())
        
        viewController1.tabBarItem.image = UIImage(named: ResourcesEnum.GridIcon.rawValue)
        viewController2.tabBarItem.image = UIImage(named: ResourcesEnum.ShoppingCartIcon.rawValue)
        viewController3.tabBarItem.image = UIImage(named: ResourcesEnum.UserIcon.rawValue)

        setViewControllers([viewController1, viewController2, viewController3], animated: true)
    }
}
