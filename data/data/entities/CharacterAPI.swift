//
//  CharacterAPI.swift
//  data
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import ObjectMapper

public struct CharacterAPI {
    
    public var id: Int?
    public var fullName: String?
    public var personality: String?
    public var rank: String?
    public var movies: [MovieAPI] = []
}

extension CharacterAPI: Mappable {
    
    public init?(map: Map) {
        mapping(map: map)
    }
    
    public mutating func mapping(map: Map) {
        id <- map["id"]
        fullName <- map["full_name"]
        personality <- map["personality"]
        rank <- map["rank"]
        movies <- map["movies"]
    }
}
