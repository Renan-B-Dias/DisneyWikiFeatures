//
//  MovieListViewModel.swift
//  moviesList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import data
import models
import RxCocoa

public protocol MovieListRouterProtocol: class {
    
    func goToMovieDetailsWith(id: Int)
}

struct MovieListViewModel {
    
    weak var router: MovieListRouterProtocol?
    
    private let repository: MoviesRepositoryProtocol
    
//     We must create this initializer because there's a private property
    init(repository: MoviesRepositoryProtocol, router: MovieListRouterProtocol) {
        self.repository = repository
        self.router = router
    }
}

extension MovieListViewModel: MovieListViewModelProtocol {
    
    var movies: Driver<[MovieTableViewCellProtocol]> {
        return repository.getAllMovies()
            .map { (moviesAPI) in moviesAPI.compactMap { Movie(movieAPI: $0) } }
            .map { (movies) in movies.map { MovieTableViewCellModel(id: $0.id, posterURL: nil, name: $0.name) } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func didTapMovieWith(id: Int) {
        router?.goToMovieDetailsWith(id: id)
    }
}
