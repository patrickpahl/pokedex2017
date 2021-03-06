//
//  PokemonController.swift
//  Pokedex2017
//
//  Created by Patrick Pahl on 4/30/17.
//  Copyright © 2017 Patrick Pahl. All rights reserved.
//

import Foundation

class PokemonController {
    
    static let baseURL = "http://pokeapi.co/api/v2/pokemon/"
    
    static func fetchPokemon(for searchTerm: String, completion: @escaping (Pokemon?) -> Void) {
        
        let searchURL = baseURL + searchTerm.lowercased()
        guard let url = URL(string: searchURL) else { completion(nil); return }
        
        NetworkController.performRequest(for: url, httpMethod: .Get) { (data, error) in
            guard let data = data, let response = String(data: data, encoding: .utf8) else { completion(nil); NSLog("No data returned."); return }
            
            guard let pokemonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else {
                NSLog("Unable to serialize json./n Response: \(response)")
                return
            }
            let pokemon = Pokemon(json: pokemonDict)
            completion(pokemon)
        }
    }
}
