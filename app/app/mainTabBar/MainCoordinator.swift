//
//  MainCoordinator.swift
//  app
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit
import characterList
import moviesList

final class MainCoordinator {
    
    private let tabViewController = MainTabBarBuilder.build()
    
    func start(window: UIWindow) {
        window.rootViewController = tabViewController
        window.makeKeyAndVisible()
        addTabs()
    }
    
    private func addTabs() {
        let characterListViewController = CharacterListBuilder.build()
        let moviesListViewController = MovieListViewController()
        
        characterListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        moviesListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        let viewControllers = [
            characterListViewController,
            moviesListViewController
        ]
        
        tabViewController.setViewControllers(viewControllers, animated: true)
    }
}
