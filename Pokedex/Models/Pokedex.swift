//
//  Pokedex.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import Foundation

struct Pokedex {
    var pages: [PokedexPage] = []
    var pokemonList: [PokemonDetail] = []
}


struct PokedexPage: Decodable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [PokemonInfo]?
}

struct PokemonInfo: Decodable {
    var name: String?
    var url: String?
}

struct PokemonDetail: Decodable {
    var id: Int
    var name: String?
    var sprites: Sprite?
    var types: [Type]?
    var stats: [Stat]?
}

struct Sprite: Decodable {
    var back_default: String?
    var back_female: String?
    var back_shiny: String?
    var back_shiny_female: String?
    var front_default: String?
    var front_female: String?
    var front_shiny: String?
    var front_shiny_female: String?
}

struct Type: Decodable {
    var slot: Int?
    var type: PokemonType?
}

struct PokemonType: Decodable {
    var name: String?
    var url: String?
}

struct Stat: Decodable {
    var base_stat: Int?
    var effort: Int?
    var stat: PokemonStat?
}

struct PokemonStat: Decodable {
    var name: String?
    var url: String?
}
