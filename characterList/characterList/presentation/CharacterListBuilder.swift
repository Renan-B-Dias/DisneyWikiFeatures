//
//  CharacterListBuilder.swift
//  characterList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit

public enum CharacterListBuilder {
    
    public static func build() -> UIViewController {
        let interactor = CharacterListInteractor()
        let presenter = CharacterListPresenter(interactor: interactor)
        return CharacterListViewController(presenter: presenter)
    }
}
