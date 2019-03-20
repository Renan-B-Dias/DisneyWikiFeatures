//
//  Character.swift
//  characterList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import data

struct Character {
    
    let id: Int
    let fullName: String
//        public let rank: String
    let personality: String
}

extension Character {

    init?(characterAPI: CharacterAPI) {
        guard let id = characterAPI.id,
            let fullName = characterAPI.fullName,
            //            let rank = characterAPI.rank,
            let personality = characterAPI.personality else {
                return nil
        }

        self.init(id: id, fullName: fullName, personality: personality)
    }
}
