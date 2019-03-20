//
//  Movie.swift
//  moviesList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import data

struct Movie {
    
    let id: Int
    let name: String
//    private let releaseDate: String
    let runningTime: String
    let grossRevenue: String
    let synopsis: String
}

extension Movie {
    
    init?(movieAPI: MovieAPI) {
        guard let id = movieAPI.id,
            let name = movieAPI.name,
            let runningTime = movieAPI.runningTime,
            let grossRevenue = movieAPI.grossRevenue,
            let synopsis = movieAPI.synopsis else { return nil }
        
        self.init(id: id, name: name, runningTime: runningTime, grossRevenue: grossRevenue, synopsis: synopsis)
    }
}
