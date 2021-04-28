//
//  PokedexRouter.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import Foundation

protocol PokedexRoutingLogic {
    func showPokemonDetails()
}

extension PokedexRoutingLogic where Self: PokedexViewController {
    
    func showPokemonDetails() {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "PokemonViewController") as? PokemonViewController else { return }
        destination.viewModel = PokemonViewModel()
        destination.viewModel.pokemon = self.viewModel.selectedPokemon
        navigationController?.show(destination, sender: nil)
    }
}

