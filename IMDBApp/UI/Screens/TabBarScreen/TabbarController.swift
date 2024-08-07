//
//  TabbarController.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = .black
        self.tabBar.isTranslucent = false
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        homeVC.tabBarItem.title = "Home"
    
        let searchVC = UINavigationController(rootViewController: SearchViewController()) 
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchVC.tabBarItem.title = "Search"
        
        let watchListVC = WatchListViewController()
        watchListVC.tabBarItem.image = UIImage(systemName: "bookmark")
        watchListVC.tabBarItem.title = "WatchList"
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        profileVC.tabBarItem.title = "Profile"
        
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .primaryYellow
    
        setViewControllers([homeVC, searchVC, watchListVC, profileVC], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

