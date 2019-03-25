//
//  MovieDetailsViewModel.swift
//  movieDetails
//
//  Created by Renan Benatti Dias on 22/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import data
import models
import RxSwift
import RxCocoa
import UI
import base

public protocol MovieDetailsRouterProtocol: class {
    
    func goToCharacterWith(id characterId: Int)
}

final class MovieDetailsViewModel {
    
    weak var router: MovieDetailsRouterProtocol?
    
    private let movieId: Int
    private let repository: MoviesRepositoryProtocol
    
    var movieViewModels: [BaseTableViewCell] = []
    
    public init(movieId: Int, repository: MoviesRepositoryProtocol, router: MovieDetailsRouterProtocol) {
        self.movieId = movieId
        self.repository = repository
        self.router = router
    }
    
    lazy var movieObservable: Observable<Movie> = {
        return repository.getMovie(id: movieId)
            .map { (movieAPI) -> Movie in
                if let movie = Movie(movieAPI: movieAPI) {
                    return movie
                }

                throw MappingError.mappingError
        }
        .asObservable()
        .share()
    }()
}

extension MovieDetailsViewModel: MovieDetailsProtocol {

    var reloadTableView: Driver<Void> {
        return movieObservable
            .map { (movie) -> [BaseTableViewCell] in
                let headerModel = CharacterDetailsHeaderTableViewCellModel(imageURL: nil)

                let sybopsisHeaderModel = SimpleLabelTableViewCellModel(id: nil, text: "Synopsys", font: UIFont.systemFont(ofSize: 24))
                let sybopsisModel = SimpleLabelTableViewCellModel(id: nil, text: movie.synopsis, font: UIFont.systemFont(ofSize: 17))

                let grossRevenueHeaderModel = SimpleLabelTableViewCellModel(id: nil, text: "Gross Revenue", font: UIFont.systemFont(ofSize: 20))
                let grossRevenueModel = SimpleLabelTableViewCellModel(id: nil, text: movie.grossRevenue, font: UIFont.systemFont(ofSize: 17))

                let runningTimeHeaderModel = SimpleLabelTableViewCellModel(id: nil, text: "Running Time", font: UIFont.systemFont(ofSize: 20))
                let runningTimeModel = SimpleLabelTableViewCellModel(id: nil, text: movie.runningTime, font: UIFont.systemFont(ofSize: 17))
                
                let charactersHeader = SimpleLabelTableViewCellModel(id: nil, text: "Characters", font: UIFont.boldSystemFont(ofSize: 24))
                let charactersViewModels = movie.characters.map { SimpleLabelTableViewCellModel(id: $0.id, text: $0.fullName, font: UIFont.systemFont(ofSize: 17)) }

                var viewModels: [BaseTableViewCell] = [
                    headerModel,
                    sybopsisHeaderModel,
                    sybopsisModel,
                    grossRevenueHeaderModel,
                    grossRevenueModel,
                    runningTimeHeaderModel,
                    runningTimeModel,
                    charactersHeader
                ]
                
                viewModels.append(contentsOf: charactersViewModels)

                return viewModels
            }
            .do(onNext: { [weak self] (viewModels) in
                guard let self = self else { return }
                self.movieViewModels = viewModels
            }, onError: { [weak self] (error) in
                guard let self = self else { return }
                self.movieViewModels = [SimpleLabelTableViewCellModel(id: nil, text: error.localizedDescription, font: UIFont.systemFont(ofSize: 17))]
            })
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
    }
    
    var movieTitle: Driver<String> {
        return movieObservable
            .map { $0.name }
            .asDriver(onErrorJustReturn: "Character")
    }
    
    func didTapAt(index: Int) {
        if let characterViewModel = movieViewModels[index] as? SimpleLabelTableViewCellModel, let id = characterViewModel.id {
            router?.goToCharacterWith(id: id)
        }
    }
}
