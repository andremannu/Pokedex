//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import Foundation
import RxSwift
import RxCocoa

class PokedexViewModel {
    
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let isError = BehaviorRelay<Error?>(value: nil)
    private let dataLoadedRelay =  BehaviorRelay<Bool>(value: false)
    
    private let service: PokemonService!
    
    //Pokedex
    var pokedex = Pokedex()

    //Actual Page
    var pokedexPage: PokedexPage?
    
    //Selected Pokemon
    var selectedPokemon: PokemonDetail?
    
    var firstLoad = true
    
    private let disposeBag = DisposeBag()
    
    
    init(service: PokemonService) {
        self.service = service
    }
    
    func getPokemonList(url: String) {
        isLoadingRelay.accept(true)
        
        service.getPokedexPage(url: url).asObservable()
            .subscribe(onNext: { (pokedexPage) in
                self.pokedexPage = pokedexPage
                self.pokedex.pages.append(pokedexPage)
                if let results = pokedexPage.results {
                    for pokemonInfo in results {
                        self.getPokemon(url: pokemonInfo.url!)
                    }
                }
                else {
                    self.isLoadingRelay.accept(false)
                }
                
            },onError: { (error) in
                self.isLoadingRelay.accept(false)
                self.isError.accept(error)
            })
            .disposed(by: disposeBag)
    }
    
    func getPokemon(url: String) {
        service.getPokemon(url: url).asObservable()
            .subscribe(onNext: { (pokemon) in
                self.isLoadingRelay.accept(false)
                self.pokedex.pokemonList.append(pokemon)
                if let results = self.pokedexPage?.results, self.pokedex.pokemonList.count % (results.count) == 0 {
                    self.pokedex.pokemonList = self.pokedex.pokemonList.sorted {$0.id < $1.id}
                    self.dataLoadedRelay.accept(true)
                }
            },onError: { (error) in
                self.isLoadingRelay.accept(false)
                self.isError.accept(error)
            })
            .disposed(by: disposeBag)
    }
}

extension PokedexViewModel {
    
    var isLoadingViewHidden: Driver<Bool> {
        isLoadingRelay.asDriver()
    }
    
    var errorVerified: Driver<Error?> {
        isError.asDriver()
    }
    
    var pokemonLoaded: Driver<Bool> {
        dataLoadedRelay.asDriver()
    }
}
