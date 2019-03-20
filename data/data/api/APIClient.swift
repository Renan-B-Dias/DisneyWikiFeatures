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

// MARK: - Remove and improve later
let provider = MoyaProvider<CharactersTarget>( endpointClosure: { (target) -> Endpoint in
    
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

public final class APIClient {
    
    static let baseURLString = "http://192.168.1.80:3000/api/"
    static let version = "v1/"
    static let baseURL = URL(string: "\(baseURLString)\(version)")!
}

extension APIClient: CharactersAPIProtocol {
    
    public func getAllCharacters() -> Single<[CharacterAPI]> {
        return provider.rx
            .request(.getAllCharacters)
            .mapArray(CharacterAPI.self)
    }
    
    public func getCharacter(id: Int) -> Single<CharacterAPI> {
        return provider.rx
            .request(.getCharacter(id: id))
            .mapObject(CharacterAPI.self)
    }
}

