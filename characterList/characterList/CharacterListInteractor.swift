//
//  CharacterListInteractor.swift
//  characterList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import RxSwift

protocol CharacterListInteractorProtocol {
    
    func getAllCharacters() -> Single<[Character]>
}

final class CharacterListInteractor {
    
}

extension CharacterListInteractor: CharacterListInteractorProtocol {
    
    func getAllCharacters() -> Single<[Character]> {
        return .just([])
    }
}
