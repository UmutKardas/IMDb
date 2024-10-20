//
//  MainTabBarViewController.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 15.10.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabBar()
    }

    private func setupTabBar() {
        let homeView = UINavigationController(rootViewController: HomeViewController())
        let searchView = UINavigationController(rootViewController: SearchViewController())

        homeView.tabBarItem.image = UIImage(systemName: "house")
        homeView.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        homeView.isNavigationBarHidden = true

        searchView.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        setViewControllers([homeView, searchView], animated: true)
    }
}

#Preview {
    MainTabBarViewController()
}
