//
//  CharactersTarget.swift
//  data
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import Moya
import RxSwift

public protocol CharactersAPIProtocol {
    
    func getAllCharacters() -> Single<[CharacterAPI]>
    func getCharacter(id: Int) -> Single<CharacterAPI>
}

enum CharactersTarget {
    
    case getAllCharacters
    case getCharacter(id: Int)
}

extension CharactersTarget: BaseTargetType {
    
    var path: String {
        switch self {
        case .getAllCharacters:
            return "characters/"
        case .getCharacter(let id):
            return "characters/\(id)"
        }
    }
    
//    var method: Moya.Method {
//        return .get
//    }
//    
//    var task: Task {
//        return .requestPlain
//    }
}

