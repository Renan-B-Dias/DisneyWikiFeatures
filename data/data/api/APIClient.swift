//
//  APIClient.swift
//  data
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import Moya
import Moya_ObjectMapper
import RxSwift

public final class APIClient {
    
    static let baseURLString = "http://192.168.1.80:3000/api/"
    static let version = "v1/"
    static let baseURL = URL(string: "\(baseURLString)\(version)")!
    
    static var charactersProvider = providerFor(taget: CharactersTarget.self)
    static var moviesProvider = providerFor(taget: MoviesTarget.self)
}

private extension APIClient {
    
    static func providerFor<T: BaseTargetType>(taget: T.Type) -> MoyaProvider<T> {
        
        let provider = MoyaProvider<T>( endpointClosure: { (target) -> Endpoint in
            
            return Endpoint(url: "\(target.baseURL)\(target.path)",
                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers)
            
        }, plugins: [NetworkActivityPlugin { (change, _)  in
            switch change {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            }, NetworkLoggerPlugin(verbose: true)])
        
        return provider
    }
}
