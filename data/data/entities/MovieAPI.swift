//
//  MovieAPI.swift
//  data
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import ObjectMapper

public struct MovieAPI {
    
    public var id: Int?
    public var name: String?
    public var runningTime: String?
    public var grossRevenue: String?
    public var synopsis: String?
    public var characters: [CharacterAPI] = []
}

extension MovieAPI: Mappable {
    
    public init?(map: Map) {
        mapping(map: map)
    }
    
    public mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        runningTime <- map["running_time"]
        grossRevenue <- map["gross_revenue"]
        synopsis <- map["synopsis"]
        characters <- map["characters"]
    }
}
