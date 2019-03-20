//
//  CharacterListPresenter.swift
//  characterList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import RxSwift
import RxCocoa
import base

final class CharacterListPresenter: BasePresenter {
    
    private let getCharactersSubject = PublishSubject<Void>()
    
    private let interactor: CharacterListInteractorProtocol
    
    init(interactor: CharacterListInteractorProtocol) {
        self.interactor = interactor
        super.init()
    }
}

extension CharacterListPresenter: CharacterListPresenterProtocol {
    
    var viewModels: Driver<[CharacterTableViewCellProtocol]> {
        return getCharactersSubject
            .flatMap { [unowned self] in self.interactor.getAllCharacters() }
            .map { $0.map { CharacterTableViewCellModel(name: $0.fullName, imageURL: nil) } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func viewDidLoad() {
        getCharactersSubject.onNext(())
    }
}
