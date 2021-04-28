//
//  MockPokemonService.swift
//  PokedexTests
//
//  Created by Andrea Mannucci  on 27/04/2021.
//

import Foundation
import RxSwift

class MockPokemonService: PokemonService {
    
    var getPokedexPage: Result<PokedexPage, Error>!
    var getPokemonDetail: Result<PokemonDetail, Error>!
    
    override func getPokedexPage(url: String) -> Observable<PokedexPage> {
        return Observable.create{observer in
            
            switch self.getPokedexPage {
            case .success(let pokedexPage):
                observer.onNext(pokedexPage)
            case .failure(let error):
                observer.onError(error)
            case .none:
                break
            }

            return Disposables.create()
        }
    }
    
    override func getPokemon(url: String) -> Observable<PokemonDetail> {
        return Observable.create{ observer in
            switch self.getPokemonDetail {
            case .success(let pokemonDetail):
                observer.onNext(pokemonDetail)
            case .failure(let error):
                observer.onError(error)
            case .none:
                break
            }

            return Disposables.create()
        }
    }
}

