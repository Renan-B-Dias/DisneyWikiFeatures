//
//  MoviesTarget.swift
//  data
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import Moya
import RxSwift

public protocol MoviesAPIProtocol {
    
    func getAllMovies() -> Single<[MovieAPI]>
    func getMovie(id: Int) -> Single<MovieAPI>
}

enum MoviesTarget {
    
    case getAllMovies
    case getMovie(id: Int)
}

extension MoviesTarget: BaseTargetType {
    
    var path: String {
        switch self {
        case .getAllMovies:
            return "movies/"
            
        case .getMovie(let id):
            return "movies/\(id)"
        }
    }
}

//// Huh.......
//let moviesProvider = MoyaProvider<MoviesTarget>( endpointClosure: { (target) -> Endpoint in
//
//    return Endpoint(url: "\(target.baseURL)\(target.path)",
//        sampleResponseClosure: {.networkResponse(200, target.sampleData)},
//        method: target.method,
//        task: target.task,
//        httpHeaderFields: target.headers)
//
//}, plugins: [NetworkActivityPlugin { (change, _)  in
//    switch change {
//    case .began:
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    case .ended:
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    }
//    }, NetworkLoggerPlugin(verbose: true)])

extension APIClient: MoviesAPIProtocol {
    
    public func getAllMovies() -> Single<[MovieAPI]> {
        return APIClient.moviesProvider
            .rx.request(.getAllMovies)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .mapArray(MovieAPI.self)
    }
    
    public func getMovie(id: Int) -> Single<MovieAPI> {
        return APIClient.moviesProvider
            .rx.request(.getMovie(id: id))
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .mapObject(MovieAPI.self)
    }
}
