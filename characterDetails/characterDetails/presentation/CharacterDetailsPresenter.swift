//
//  CharacterDetailsPresenter.swift
//  characterDetails
//
//  Created by Renan Benatti Dias on 21/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import RxSwift
import RxCocoa
import models
import base

public protocol CharacterDetailsRouterProtocol: class {
    
    func goToMovieDetailsWith(id: Int)
}

final class CharacterDetailsPresenter: BasePresenter {
    
    weak var router: CharacterDetailsRouterProtocol?
    
    private let id: Int
    private let interactor: CharacterDetailsInteractorProtocol
    
    private let getCharacterSubject = PublishSubject<Int>()
    
    init(id: Int, interactor: CharacterDetailsInteractorProtocol) {
        self.id = id
        self.interactor = interactor
        super.init()
    }
    
    private lazy var characterObservable: Observable<models.Character> = {
        return getCharacterSubject
            .flatMap { [unowned self] (id) in self.interactor.getCharacter(id: id) }
            .share()
    }()
}

extension CharacterDetailsPresenter: CharacterDetailsPresenterProtocol {
    
    var viewModels: Driver<[BaseTableViewCell]> {
        return characterObservable
            .map { (character) -> [BaseTableViewCell] in
                let headerModel = CharacterDetailsHeaderTableViewCellModel(imageURL: nil)
                let personality = SimpleLabelTableViewCellModel(id: nil, text: character.personality, font: UIFont.systemFont(ofSize: 17))
                
                let movieHeader = SimpleLabelTableViewCellModel(id: nil, text: "Movies", font: UIFont.boldSystemFont(ofSize: 24))
                let moviesViewModels = character.movies.map { SimpleLabelTableViewCellModel(id: $0.id, text: $0.name, font: UIFont.systemFont(ofSize: 17)) }
                
                var viewModels: [BaseTableViewCell] = [
                    headerModel,
                    personality,
                    movieHeader
                ]
                
                viewModels.append(contentsOf: moviesViewModels)
                
                return viewModels
            }
            .asDriver(onErrorRecover: { (error) in .just([SimpleLabelTableViewCellModel(id: nil, text: error.localizedDescription, font: UIFont.systemFont(ofSize: 17))]) })
            .startWith([SimpleLabelTableViewCellModel(id: nil, text: "Loading", font: UIFont.systemFont(ofSize: 38))])
    }
    
    var viewTitle: Driver<String> {
        return characterObservable
            .map { $0.fullName }
            .asDriver(onErrorJustReturn: "Character")
    }
    
    func viewDidLoad() {
        getCharacterSubject.onNext(id)
    }
    
    func didTap(viewModel: BaseTableViewCell) {
        if let viewModel = viewModel as? SimpleLabelTableViewCellModel, let id = viewModel.id {
            router?.goToMovieDetailsWith(id: id)
        }
    }
}
