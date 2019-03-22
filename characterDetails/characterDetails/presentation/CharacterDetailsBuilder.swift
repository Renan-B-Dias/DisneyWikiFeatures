//
//  CharacterDetailsBuilder.swift
//  characterDetails
//
//  Created by Renan Benatti Dias on 21/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit

public enum CharacterDetailsBuilder {
    
    public static func build(id: Int, router: CharacterDetailsRouterProtocol) -> UIViewController {
        let interactor = CharacterDetailsInteractor()
        let presenter = CharacterDetailsPresenter(id: id, interactor: interactor)
        presenter.router = router
        return CharacterDetailsViewController(presenter: presenter)
    }
}
