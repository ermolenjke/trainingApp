//
//  MainTabBarController.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 28.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen
        tabBar.unselectedItemTintColor = .specialGray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
    }
    
    private func setupItems() {
        let mainVC = MainViewController()
//        let statisticVC = Statistic
//        let profileVC =
        
        setViewControllers([mainVC], animated: true)
    }
    
}
