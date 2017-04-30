//
//  MainViewController.swift
//  Pokedex2017
//
//  Created by Patrick Pahl on 4/30/17.
//  Copyright © 2017 Patrick Pahl. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {
    // *Added searchbar delegate
    
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var moveLabel: UILabel?
    @IBOutlet var typeLabel: UILabel?
    @IBOutlet var pokemonImageView: UIImageView?
    @IBOutlet var searchBar: UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar?.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        PokemonController.fetchPokemon(for: searchTerm) { (pokemon) in
            guard let pokemon = pokemon else { return }
            DispatchQueue.main.async {
                self.updateWith(pokemon: pokemon)
            }
        }
    }
    
    func updateWith(pokemon: Pokemon) {
        ImageController.image(forURL: pokemon.pictureURL, completion: { (image) in
            self.pokemonImageView?.image = image
        })
        
        let formattedString = NSMutableAttributedString()
        nameLabel?.attributedText = formattedString.normal(text: "Name: ").bold(text: pokemon.name.capitalized)
        moveLabel?.text = "Move: " + pokemon.moveName.capitalized
        typeLabel?.text = "Type: " + pokemon.type.capitalized
    }
}

extension NSMutableAttributedString {
    func bold(text:String) -> NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17.0) ]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func normal(text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }

    
    
    
    
    
}
