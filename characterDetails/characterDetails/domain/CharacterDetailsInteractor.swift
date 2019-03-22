//
//  CharacterDetailsInteractor.swift
//  characterDetails
//
//  Created by Renan Benatti Dias on 21/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import RxSwift
import base
import data
import models

protocol CharacterDetailsInteractorProtocol {
    
    func getCharacter(id: Int) -> Single<models.Character>
}

final class CharacterDetailsInteractor {
    
    private let repository: CharactersRepositoryProtocol = CharactersRepository()
}

extension CharacterDetailsInteractor: CharacterDetailsInteractorProtocol {
    
    func getCharacter(id: Int) -> Single<models.Character> {
        return repository.getCharacter(id: id)
            .flatMap {
                if let character = Character(characterAPI: $0) {
                    return .just(character)
                }
                return .error(MappingError.mappingError)
            }
    }
}
