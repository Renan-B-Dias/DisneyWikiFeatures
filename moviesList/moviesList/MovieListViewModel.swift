//
//  MovieListViewModel.swift
//  moviesList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import data
import RxCocoa

struct MovieListViewModel {
    
    private let repository: MoviesRepositoryProtocol
    
    init(repository: MoviesRepositoryProtocol) {
        self.repository = repository
    }
}

extension MovieListViewModel: MovieListViewModelProtocol {
    
    var movies: Driver<[MovieTableViewCellProtocol]> {
        return repository.getAllMovies()
            .map { (moviesAPI) in moviesAPI.compactMap { Movie(movieAPI: $0) } }
            .map { (movies) in movies.map { MovieTableViewCellModel(posterURL: nil, name: $0.name) } }
            .asDriver(onErrorJustReturn: [])
    }
}
