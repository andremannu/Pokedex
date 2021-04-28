//
//  PokedexCell.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import UIKit

class PokedexCell: UITableViewCell {

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    
    var cache = NSCache<AnyObject, AnyObject>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setPokemonImage(url: String) {
        self.pokemonImageView.loadImageUrlString(urlString: url, cache: self.cache)
    }
}
