//
//  TabBarViewController.swift
//  CoinValueApp
//
//  Created by Алексей Орловский on 27.08.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       configureTabBar()
    }
    
    func configureTabBar() {
        viewControllers = [
            customViewTabBar(viewController: UINavigationController(rootViewController: HomeViewController()), title: "Home", image: UIImage(systemName: "house")),
            customViewTabBar(viewController: UINavigationController(rootViewController: CryptoViewController()), title: "Crypto", image: UIImage(systemName: "bitcoinsign.circle.fill"))
        ]
    }
    
    func customViewTabBar(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem?.image = image
        
        tabBar.tintColor = .label
        return viewController
    }
}
