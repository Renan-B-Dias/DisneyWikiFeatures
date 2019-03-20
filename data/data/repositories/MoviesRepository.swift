//
//  MoviesRepository.swift
//  data
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import RxSwift

public protocol MoviesRepositoryProtocol {
    
    func getAllMovies() -> Single<[MovieAPI]>
    func getMovie(id: Int) -> Single<MovieAPI>
}

public final class MoviesRepository {
    
    private let apiClient: MoviesAPIProtocol = APIClient()
    
    public init() {}
}

extension MoviesRepository: MoviesRepositoryProtocol {
    
    public func getAllMovies() -> Single<[MovieAPI]> {
        return apiClient.getAllMovies()
    }
    
    public func getMovie(id: Int) -> Single<MovieAPI> {
        return apiClient.getMovie(id: id)
    }
}
