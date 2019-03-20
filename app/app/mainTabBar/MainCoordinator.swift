//
//  MainCoordinator.swift
//  app
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit
import characterList

final class MainCoordinator {
    
    private let tabViewController = MainTabBarBuilder.build()
    
    func start(window: UIWindow) {
        window.rootViewController = tabViewController
        window.makeKeyAndVisible()
        addTabs()
    }
    
    private func addTabs() {
        let characterListViewController = CharacterListBuilder.build()
        
        characterListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        
        let viewControllers = [
            characterListViewController
        ]
        
        tabViewController.setViewControllers(viewControllers, animated: true)
    }
}
