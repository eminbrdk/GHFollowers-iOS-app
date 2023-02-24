//
//  GFTabbarController.swift
//  GHFollowers
//
//  Created by Muhammed Emin Bardakcı on 23.02.2023.
//

import UIKit

class GFTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        UITabBar.appearance().backgroundColor = .systemGray4
        
        viewControllers = [createSearchNC(), createFavoriteNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteNC() -> UINavigationController {
        let favoriteVC = FavoriteListVC()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteVC)
    }
}
