//
//  Pokemon.swift
//  Pokedex2017
//
//  Created by Patrick Pahl on 4/30/17.
//  Copyright © 2017 Patrick Pahl. All rights reserved.
//

import Foundation

// Info.plist --> AppTransportSecurity --> Allow arbitrary loads --> Yes
// http://jsonviewer.stack.hu/
// http://pokeapi.co/api/v2/pokemon/1/
// http://pokeapi.co/


class Pokemon {
    
    private let nameKey = "name"
    private let moveNameKey = "name"
    private let typeNameKey = "name"
    private let imageKey = "front_shiny"
    private let movesKey = "moves"
    private let moveKey = "move"
    private let typesKey = "types"
    private let typeKey = "type"
    private let spritesKey = "sprites"
    
    let name: String
    let moveName: String
    let type: String
    let pictureURL: String
    
    init(name: String, moveName: String, type: String, pictureURL: String) {
        
        self.name = name
        self.moveName = moveName
        self.type = type
        self.pictureURL = pictureURL
    }
    
    init?(json: [String: Any]) {
        guard let name = json[nameKey] as? String,
        let movesArray = json[movesKey] as? [[String: Any]],
        let movesDictionary = movesArray.first,
        let smallMovesDictionary = movesDictionary[moveKey] as? [String: String],
        let moveName = smallMovesDictionary[moveNameKey],
        let typeArray = json[typesKey] as? [[String: Any]],
        let typeDictionary = typeArray.first,
        let smallTypeDictionary = typeDictionary[typeKey] as? [String: String],
        let typeName = smallTypeDictionary[typeNameKey],
        let spritesArray = json[spritesKey] as? [String: Any],
        let pictureURL = spritesArray[imageKey] as? String else { return nil }
        
        self.name = name
        self.moveName = moveName
        self.type = typeName
        self.pictureURL = pictureURL
    }
    
}
