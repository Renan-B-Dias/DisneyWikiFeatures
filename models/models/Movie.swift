//
//  Movie.swift
//  models
//
//  Created by Renan Benatti Dias on 21/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import data

public struct Movie {
    
    public let id: Int
    public let name: String
//    private let releaseDate: String
    public let runningTime: String
    public let grossRevenue: String
    public let synopsis: String
}

extension Movie {
    
    public init?(movieAPI: MovieAPI) {
        guard let id = movieAPI.id,
            let name = movieAPI.name,
            let runningTime = movieAPI.runningTime,
            let grossRevenue = movieAPI.grossRevenue,
            let synopsis = movieAPI.synopsis else { return nil }
        
        self.init(id: id, name: name, runningTime: runningTime, grossRevenue: grossRevenue, synopsis: synopsis)
    }
}

