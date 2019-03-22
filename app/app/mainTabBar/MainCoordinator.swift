//
//  MainCoordinator.swift
//  app
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit
import characterList
import characterDetails
import moviesList

final class MainCoordinator {
    
    private let navigationController = UINavigationController()
    private let tabViewController = MainTabBarBuilder.build()
    
    func start(window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        addTabs()
    }
    
    private func addTabs() {
        let characterListViewController = CharacterListBuilder.build(router: self)
        
        let moviesListViewController = MovieListViewController()
        
        characterListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        moviesListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        let viewControllers = [
            characterListViewController,
            moviesListViewController
        ]
        
        tabViewController.setViewControllers(viewControllers, animated: true)
        navigationController.setViewControllers([tabViewController], animated: true)
    }
}

// MARK: - CharacterListRouterProtocol
extension MainCoordinator: CharacterListRouterProtocol {
    
    func goToCharacterWith(id characterId: Int) {
        let characterDetailsViewController = CharacterDetailsBuilder.build(id: characterId, router: self)
        navigationController.pushViewController(characterDetailsViewController, animated: true)
    }
}

// MARK: - CharacterDetailsRouterProtocol
extension MainCoordinator: CharacterDetailsRouterProtocol {
    
    func goToMovieDetailsWith(id: Int) {
        let moviesListViewController = MovieListViewController()
        navigationController.pushViewController(moviesListViewController, animated: true)
    }
}
