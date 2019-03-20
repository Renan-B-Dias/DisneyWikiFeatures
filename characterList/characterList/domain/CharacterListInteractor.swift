//
//  CharacterListInteractor.swift
//  characterList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import RxSwift
import data

protocol CharacterListInteractorProtocol {
    
    func getAllCharacters() -> Single<[Character]>
}

final class CharacterListInteractor {
    
    private let repository: CharactersRepositoryProtocol = CharactersRepository()
    
    public init() {}
}

extension CharacterListInteractor: CharacterListInteractorProtocol {
    
    func getAllCharacters() -> Single<[Character]> {
        return repository.getAllCharacters()
            .map { (characters) in characters.compactMap { Character(characterAPI: $0) } }
    }
}
