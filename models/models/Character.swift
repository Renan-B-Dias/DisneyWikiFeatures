//
//  Character.swift
//  models
//
//  Created by Renan Benatti Dias on 21/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import data

public struct Character {
    
    public let id: Int
    public let fullName: String
    public let rank: String
    public let personality: String
    public let movies: [Movie]
}

extension Character {
    
    public init?(characterAPI: CharacterAPI) {
        guard let id = characterAPI.id,
            let fullName = characterAPI.fullName,
            let rank = characterAPI.rank,
            let personality = characterAPI.personality else {
                return nil
        }
        
        let movies = characterAPI.movies.compactMap { Movie(movieAPI: $0) }
        
        self.init(id: id, fullName: fullName, rank: rank, personality: personality, movies: movies)
    }
}

